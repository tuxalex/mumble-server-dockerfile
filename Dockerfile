# VERSION 0.1
# DESCRIPTION:    mumbler server conatiner
# TO_BUILD:       docker build -rm -t mumble-server .
# TO_RUN:         docker run --name=mumble-server -d -v /home/mumble-server_config/:/home/mumble-server/config/ -v /var/log/mumble-server/:/var/log/mumble-server/ -p 64738:64738/tcp -p 64738:64738/udp -ti tuxcloud.fr/mumble-server

FROM ubuntu-debootstrap:14.04
MAINTAINER Alexan Andrieux <alexan.andrieux@gmail.com> 
#BASE ON Matt Conroy matt@conroy.cc

# Upgrade the build and include the universe repo.
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Install the mumble dependencies
#RUN apt-get install -y libterm-readline-perl-perl
RUN apt-get install -y  mumble-server
#RUN mkdir -p /var/run/sshd

# Install supervisor
#RUN apt-get install -y supervisor
#RUN mkdir -p /var/log/supervisor
#RUN locale-gen en_US en_US.UTF-8
#ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#RUN useradd -m -p admin -r -s /bin/bash -g root admin
#RUN echo "admin:admin" | chpasswd 
#RUN sudo adduser admin sudo

# Add the start script
ADD start.sh /tmp/start.sh
RUN chmod 700 /tmp/start.sh


VOLUME ["/home/mumble-server/config"]
VOLUME ["/var/log/mumble-server"]

# Make the ports available for SSH and Mumble.
#EXPOSE 22
EXPOSE 64738

CMD ["/tmp/start.sh"]

# Server startup command
#CMD ["/usr/bin/supervisord"]

# Set the initial superuser password to admin
#RUN /usr/sbin/murmurd -ini /home/mumble-server/config/mumble-server.ini
