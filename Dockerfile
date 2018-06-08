FROM debian:7
MAINTAINER Tortus Tek Inc
EXPOSE 3000
WORKDIR /root

# Install build requirements
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get autoremove -y
RUN apt-get install -y autoconf subversion bison build-essential libssl-dev git curl wget libpq-dev

# Install ruby-build
RUN wget https://github.com/rbenv/ruby-build/archive/v20180601.tar.gz
RUN tar -xf v20180601.tar.gz && cd ruby-build-20180601 && ./install.sh

# Install ruby
RUN mkdir -p /opt/rubies
RUN ruby-build -v 1.8.7-p375 /opt/rubies/ruby-1.8.7-p375
ENV PATH /opt/rubies/ruby-1.8.7-p375/bin:$PATH

# Lock bundler to a specific version, in case future versions drop Ruby 1.8
RUN gem install bundler -v 1.10.6
# Some very old apps need rake 0.7.3, so we may as well install it.
RUN gem install rake -v 0.7.3
RUN gem install rake -v 0.8.7
RUN gem install slimgems
RUN gem install i18n -v 0.6.11
RUN gem install json -v 1.8.3
RUN gem install rails -v 1.2.6
RUN gem install money -v 4.0.2
RUN gem install soap4r -v 1.5.8
RUN gem install postgres -v 0.7.9.2008.01.28

WORKDIR /root
CMD bash