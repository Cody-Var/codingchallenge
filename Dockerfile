#Configure a Linux OS image - Taking Ubuntu:latest(should be locking the version, using latest just for testing pupose)
FROM ubuntu:latest
#Making sure all packages are update to date and all pending security updates are applied against the default OS repositories.
RUN apt-get update && apt-get upgrade
RUN apt-get install -y python pip 
# disable IPv6 system wide.
RUN echo net.ipv6.conf.all.disable_ipv6 = 1 >>/etc/sysctl.conf && sysctl -p
# Install telnet and tree
RUN apt-get install -y tree telnet
# Installing appropriate web-server to deploy application
RUN pip install flask
# Set the max "open files" limit across all users/processes, soft & hard, to 65535
RUN echo *    soft nofile 65536 >>/etc/security/limits.conf
RUN echo *    hard nofile 65536 >>/etc/security/limits.conf
# Bundling application code to the docker image 
COPY tiny_app.py /opt/
ENTRYPOINT FLASK_APP=/opt/tiny_app.py flask run --host=0.0.0.0 --port=80
