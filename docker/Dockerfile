
FROM node:6-slim
MAINTAINER Andy Baird <andy.abird@madwiremedia.com>

# Update packages
RUN apt-get update -y --fix-missing;
RUN apt-get upgrade -y;

# Install packages
RUN apt-get install -y \
	build-essential \
	git \
	redis-server \
	tcl8.5 \
	telnet \
	wget

# cleanup
RUN apt-get clean;

# install dumb init for signal passing
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.3/dumb-init_1.0.3_amd64
RUN chmod +x /usr/local/bin/dumb-init

#copy in the package json to the app directory to run the install
# (this directory should be linked over with -v on run so you can live edit your code locally)
ADD ./package.json /root/package.json

# install npm modules
RUN cd /root; npm install

# install nodemon globally
RUN npm install nodemon -g

# expose the port (the number in webport.txt will override this)
EXPOSE 8889

#wire in a startup script
ADD bootstrap.sh /root/bootstrap.sh

CMD /root/bootstrap.sh