FROM steinwaywhw/docker-texlive:latest
MAINTAINER Steinway Wu "http://steinwaywu.com/"

RUN apt-get update
RUN apt-get install -y git build-essential curl python-software-properties zlib1g-dev zip unzip wget

# Install Node

RUN mkdir /opt/.npm
RUN mkdir /opt/nodejs
ENV PATH $PATH:/opt/.npm/bin
WORKDIR /opt/nodejs
RUN curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
RUN ./configure --prefix=/opt/.npm
RUN make install -j4
RUN curl https://www.npmjs.org/install.sh | sh
# OR curl https://www.npmjs.org/install.sh | clean=[yes/no] sh

# Install Grunt 
RUN npm install -g grunt-cli

# Install Redis
RUN apt-get install -y redis-server 

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# Install Aspell
RUN apt-get install -y aspell aspell-en

# Install latexmk
RUN tlmgr install latexmk

# Install ShareLatex
RUN mkdir -p /var/www
RUN git clone https://github.com/steinwaywhw/sharelatex.git /var/www/sharelatex
WORKDIR /var/www/sharelatex

RUN npm install
RUN grunt install 
RUN grunt deploy
RUN /var/www/sharelatex/package/script/deploy.sh 
