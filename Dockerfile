FROM ubuntu:latest
RUN apt-get update && apt-get upgrade && apt-get install -y python
RUN apt-get install -y pip 
RUN apt-get install -y tree
RUN apt-get install -y telnet
RUN pip install flask
COPY tiny_app.py /opt/
ENTRYPOINT FLASK_APP=/opt/tiny_app.py flask run --host=0.0.0.0 --port=80
