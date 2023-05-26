parameters = [
   #frontend parameters
   { name= "dev.frontend.catalogue_url", value = "http://catalogue-dev.devopspract.online:8080/", type= "String"},
   { name= "dev.frontend.user_url", value = "http://user-dev.devopspract.online:8080/", type= "String"},
   { name= "dev.frontend.cart_url", value = "http://cart-dev.devopspract.online:8080/", type= "String"},
   { name= "dev.frontend.shipping_url", value = "http://shipping-dev.devopspract.online:8080/", type= "String"},
   { name= "dev.frontend.payment_url", value = "http://payment-dev.devopspract.online:8080/", type= "String"},
   #user Parameters
   { name= "dev.user.mongo", value = "true", type= "String"},
   { name= "dev.user.redis_host", value = "redis-dev.devopspract.online", type= "String"},
   { name= "dev.user.mongo_url", value = "mongodb://mongodb-dev.devopspract.online:27017/catalogue", type= "String"},
   #shipping Parameters
   { name= "dev.shipping.cart_endpoint", value = "cart-dev.devopspract.online:8080", type= "String"},
   { name= "dev.shipping.db_host", value = "mysql-dev.devopspract.online", type= "String"},
   #payment Parameters
   { name= "dev.payment.cart_host", value = "cart-dev.devopspract.online", type= "String"},
   { name= "dev.payment.cart_port", value = "8080", type= "String"},
   { name= "dev.payment.user_host", value = "user-dev.devopspract.online", type= "String"},
   { name= "dev.payment.user_port", value = "8080", type= "String"},
   { name= "dev.payment.amqp_host", value = "rabbitmq-dev.devopspract.online", type= "String"},
   #dispatch Parameters
   { name= "dev.dispatch.amqp_host", value = "rabbitmq-dev.devopspract.online", type= "String"},
   #catalogue Parameters
   { name= "dev.catalogue.mongo", value = "true", type= "String"},
   { name= "dev.catalogue.mongo_url", value = "mongodb://mongodb-dev.devopspract.online:27017/catalogue", type= "String"},
   #cart Parameters
   { name= "dev.cart.redis_host", value = "redis-dev.devopspract.online", type= "String"},
   { name= "dev.cart.catalogue_host", value = "catalogue-dev.devopspract.online", type= "String"},
   { name= "dev.cart.catalogue_port", value = "8080", type= "String"}
]


secrets = [
   #mysql password
   { name= "dev.mysql.password", value = "RoboShop@1", type= "SecureString"},
   #payment service file secrets
   { name= "dev.payment.amqp_user", value = "roboshop", type= "SecureString"},
   { name= "dev.payment.amqp_pass", value = "roboshop123", type= "SecureString"},
   #rabbitmq service file secrets
   { name= "dev.rabbitmq.amqp_user", value = "roboshop", type= "SecureString"},
   { name= "dev.rabbitmq.amqp_pass", value = "roboshop123", type= "SecureString"},
   #dispatch service file secrets
   { name= "dev.dispatch.amqp_user", value = "roboshop", type= "SecureString"},
   { name= "dev.dispatch.amqp_pass", value = "roboshop123", type= "SecureString"},
   #shipping password
   { name= "dev.shipping.password", value = "RoboShop@1", type= "SecureString"}
]