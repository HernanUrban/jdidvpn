FROM hurban/jenkins-did-master
USER root
RUN apt-get update && apt-get install -y openconnect iptables expect dante-server socat

ADD scripts/connect.sh /root
ADD scripts/csd-wrapper.sh /root
RUN chmod +x /root/connect.sh
RUN chmod +x /root/csd-wrapper.sh

ADD scripts/jdidvpn.conf /etc/jdidvpn.conf

EXPOSE 1081 3389

CMD ["/root/connect.sh"]
