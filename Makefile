redis:
	@bash components/redis.sh
cart:
	@bash components/cart.sh
shipping:
	@bash components/shipping.sh
users:
	@bash components/users.sh
mongodb:
	@bash components/mongodb.sh
frontend:
	@bash components/frontend.sh
payment:
	@bash components/payment.sh
rabbitmq:
	@bash components/rabbitmq.sh
catalogue:
	@bash components/catalogue.sh
mysql:
	@bash components/mysql.sh

