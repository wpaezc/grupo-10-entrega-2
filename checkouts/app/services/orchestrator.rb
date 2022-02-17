module Services
  class Orchestrator
    attr_accessor :body, :status

    def initialize(session:, params: )
      @body = {}
      @status = 500
      @session = session
      @params = params
      @processed_entities = []
    end

    def self.process_new_order(session, params)
      orchestator = new(session: session, params: params)
      orchestator.process_new_order
      orchestator
    end

    def process_new_order
      @seller = get_seller
      return unless @seller.success
      @order = create_order
      return unless @order.success
      @agenda = create_agenda
      
      unless @agenda.success
        @order.destroy
        return
      end

      @payment = create_payment

      unless @payment.success
        @order.destroy
        @agenda.destroy
        return
      end

      @body = {order: @order.body, agenda: @agenda.body, payment: @payment.body}
      @status = 201 #created
    end

    private
      def create_payment
        payment = Payment.create(payment_data)
        self.body = payment.body
        self.status = payment.status
        payment
      end

      def payment_data
        {
          order: {
            uuid: @order.body["orderId"]
          },
          user: {
            uuid: @session.body["user_id"]
          }
        }
      end

      def create_agenda
        agenda = Agenda.create(@seller.body["uuid"], agenda_data)
        self.body = agenda.body
        self.status = agenda.status
        agenda
      end

      def agenda_data
        {
          uuid: @order.body["orderId"]
        }
      end

      def create_order
        order = Order.create(order_data)
        self.body = order.body
        self.status = order.status
        order
      end

      def order_data
        {
          item: {
            uuid: @params["item"]["uuid"]
          },
          seller: {
            uuid: @seller.body["uuid"]
          },
          user: {
            uuid: @session.body["user_id"]
          }
        }
      end

      def get_seller
        seller = Seller.get_by_product_id(@params["item"])
        self.body = seller.body
        self.status = seller.status
        seller
      end
  end
end
