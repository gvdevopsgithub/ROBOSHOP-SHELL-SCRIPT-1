source components/common.sh

CHECK_ROOT

if [ -z "$RABBITMQ_USER_PASSWORD" ]; then
  echo "Env Variable RABBITMQ_USER_PASSWORD Needed"
  exit 1
fi

PRINT "Setup YUM Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG}
CHECK_STAT $?

PRINT "Install ErLang & RabbitMQ"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y rabbitmq-server -y &>>${LOG}
CHECK_STAT $?

PRINT "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>${LOG} && systemctl start rabbitmq-server &>>${LOG} &>>${LOG}
CHECK_STAT $?

rabbitmqctl list_users | grep roboshop &>>${LOG}
if [ $? -ne 0 ]; then
  PRINT "Create RabbitMQ User"
  rabbitmqctl add_user roboshop roboshop123  &>>${LOG}
  CHECK_STAT $?
fi

PRINT "RabbitMQ User Tags and Permisiions"
rabbitmqctl set_user_tags roboshop administrator &>>${LOG} && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}
CHECK_STAT $?
