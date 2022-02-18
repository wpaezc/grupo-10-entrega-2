# Servicio de checkouts
                                                                                 
Por medio de este servicio, se puede iniciar el proceso de construcción del bien que se está comprando. En este proceso se crea una order, un agendamiento y un pago. Para iniciar este proceso se necesita tener un usuario autenticado.

A continuación, se indica cuales endpoints ofrece y las características de cada uno:
                                                                                
|||                                                                             
| --- | --- |                                                                   
| Componente | Checkouts |                                                         
| Código | checkouts |                                                             
| Método de consumo | REST |                                                    
| Despliegue | Contenedores sobre kubernetes |                                  
| Propósito | Contiene las funcionalidades que permiten crear un pedido, agendamiento de un pedido para un proveedor, y crear un pago|
                                                                                
## API                                                                          
                                                                                
### Creación de un checkout

* **Descripción**                                                               
                                                                                
|||                                                                             
| --- | --- |                                                                   
| Método | POST |                                                               
| Ruta | /checkouts |                                                
| Cuerpo |<code>{"session_id": "session_uuid", "item": {"uuid": "product_uuid"}}</code> |  

* **Respuestas**                                                                
                                                                                
| Código | Cuerpo | Descripción |                                               
| --- | --- | --- |                                                             
| 404 |<code>{"message": "La sesión no existe"}</code> | En el caso que la sesión sea inválida |
| 404 |<code>{"message": "Elemento no encontrado"}</code> | En el caso que el producto no sea encontrado para un proveedor |
| 412 |<code>{"message": "Proveedor sin disponibilidad"}</code> | En el caso que el proveedor no tenga disponibilidad para agendar una neuva orden.
| 412 |<code>{"message": "Método bloqueado por seguridad"}</code> | En el caso que el usuario ya tenga dos ordenes de pago |
| 201 | <code>{"order": {...orderData}, agenda: {...agendaData}, payment: {...paymentData}}</code>| En el caso que el pedido se agendó con éxito. |

### Consulta de salud del contenedor                                            
                                                                                
* **Descripción**                                                               
                                                                                
|||                                                                             
| --- | --- |                                                                   
| Método | GET |                                                                
| Ruta | /checkouts/health/ping |                                                  
                                                                                
* **Respuestas**                                                                
                                                                                
| Código | Cuerpo | Descripción |                                               
| --- | --- | --- |                                                             
| 200 |  <code>pong</code> | Solo para confirmar que el servicio está arriba. |