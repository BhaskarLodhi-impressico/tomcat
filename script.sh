useradd -m -d /opt/tomcat -U -s /bin/false tomcat

apt update

apt install default-jdk -y

wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.5/bin/apache-tomcat-10.1.5.tar.gz

mkdir /opt/tomcat 

tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1

chown -R tomcat:tomcat /opt/tomcat/

chmod -R u+x /opt/tomcat/bin

update-java-alternatives -l

echo "[Unit]
Description=Tomcat
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/tomcat.service

systemctl daemon-reload

systemctl start tomcat

systemctl status tomcat

systemctl enable tomcat

ufw allow 8080

