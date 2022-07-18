curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
cd /home/roboshop
rm -rf cart
unzip /tmp/cart.zip
mv cart-main cart
cd cart
npm install
set -i -e 's/REDIS_ENDPOINT/redis.devopsb656.online/' -e 's/CATALOGUE_ENDPOINT/catalogue.devopsb656.online/' /home/roboshop/cart/systemd.service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl start cart
systemctl enable cart
