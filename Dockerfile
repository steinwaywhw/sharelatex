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
#RUN grunt deploy

# RUN mkdir /etc/sharelatex
# RUN mv config/settings.development.coffee /etc/sharelatex/settings.coffee
# ENV SHARELATEX_CONFIG /etc/sharelatex/settings.coffee
# RUN sed -ri "s/TMP_DIR = Path.*/TMP_DIR = '\/var\/lib\/sharelatex\/tmp'/g" /etc/sharelatex/settings.coffee
# RUN sed -ri "s/DATA_DIR = Path.*/DATA_DIR = '\/var\/lib\/sharelatex\/data'/g" /etc/sharelatex/settings.coffee

# RUN mkdir -p /var/lib/sharelatex/data
# RUN mkdir -p /var/lib/sharelatex/data/user_files
# RUN mkdir -p /var/lib/sharelatex/data/compiles
# RUN mkdir -p /var/lib/sharelatex/data/cache
# RUN mkdir -p /var/lib/sharelatex/tmp
# RUN mkdir -p /var/lib/sharelatex/tmp/uploads
# RUN mkdir -p /var/lib/sharelatex/tmp/dumpFolder
# RUN chown -R sharelatex:sharelatex /var/lib/sharelatex

# RUN mkdir -p /var/log/sharelatex
# RUN chown -R sharelatex:sharelatex /var/log/sharelatex

# RUN mkdir -p /etc/service/sharelatex-chat  
# RUN mkdir -p /etc/service/sharelatex-clsi
# RUN mkdir -p /etc/service/sharelatex-docstore
# RUN mkdir -p /etc/service/sharelatex-document-updater
# RUN mkdir -p /etc/service/sharelatex-filestore
# RUN mkdir -p /etc/service/sharelatex-spelling
# RUN mkdir -p /etc/service/sharelatex-tags
# RUN mkdir -p /etc/service/sharelatex-template
# RUN mkdir -p /etc/service/sharelatex-track-changes  
# RUN mkdir -p /etc/service/sharelatex-web

# RUN 

# ### In memcached.sh (make sure this file is chmod +x):
# #!/bin/sh
# # `/sbin/setuser memcache` runs the given command as the user `memcache`.
# # If you omit that part, the command will be run as root.
# exec /sbin/setuser memcache /usr/bin/memcached >>/var/log/memcached.log 2>&1

# SERVICE=chat
#     USER=sharelatex
#     GROUP=sharelatex
#     # You may need to replace this with an absolute 
#     # path to Node.js if it's not in your system PATH.
#     NODE=node
#     SHARELATEX_CONFIG=/etc/sharelatex/settings.coffee
#     LATEX_PATH=/usr/local/texlive/2014/bin/x86_64-linux

#     echo $$ > /var/run/sharelatex-$SERVICE.pid
#     chdir /var/www/sharelatex/$SERVICE
#     exec sudo -u $USER -g $GROUP env SHARELATEX_CONFIG=$SHARELATEX_CONFIG NODE_ENV=production PATH=$PATH:$LATEX_PATH $NODE app.js >> /var/log/sharelatex/$SERVICE.log 2>&1


# ### In Dockerfile:
# RUN mkdir /etc/service/memcached
# ADD memcached.sh /etc/service/memcached/run