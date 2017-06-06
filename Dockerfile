FROM maven:3.5-jdk-8

# Environment Variables
ENV HOME=/home/proc \
#   JAVA_HOME=/usr/local/java \
    JRUBY_HOME=/usr/local/jruby \
    SBT_HOME=/usr/local/sbt \
    RUBY_HOME=/usr/local/ruby 
ENV PATH="${PATH}:${JRUBY_HOME}/bin:${RUBY_HOME}/bin:${SBT_HOME}/bin"

# New user
RUN useradd proc && mkdir -p ${HOME} && chown -R proc:proc ${HOME} && echo "proc:proc" | chpasswd

# Update apt-get and install basic software, docbook style sheets
RUN \
    apt-get update && apt-get install -y \
    curl zip unzip wget tar make git gcc build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libxml2-utils xsltproc

# Install JDK
#RUN wget -nv -O ${HOME}/java.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz && \
#    mkdir ${JAVA_HOME} && \
#    tar -C ${JAVA_HOME} -zxf ${HOME}/java.tar.gz --strip 1 && \
#    rm ${HOME}/java.tar.gz

# Install Ruby
RUN wget -nv -O ${HOME}/ruby.tar.gz --no-check-certificate https://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p648.tar.gz && \
    mkdir ${RUBY_HOME} && \
    mkdir ${HOME}/ruby && \
    tar -C ${HOME}/ruby -zxf ${HOME}/ruby.tar.gz --strip 1 && \
    cd ${HOME}/ruby/ && \
    ./configure --prefix=${RUBY_HOME} --disable-install-doc && \
    make && make install && \
    rm ${HOME}/ruby.tar.gz &&\
    rm -rf ${HOME}/ruby

# Install JRuby
RUN wget -nv -O ${HOME}/jruby.tar.gz --no-check-certificate https://s3.amazonaws.com/jruby.org/downloads/1.7.24/jruby-bin-1.7.24.tar.gz && \
    mkdir ${JRUBY_HOME} && \
    tar -C ${JRUBY_HOME} -zxf ${HOME}/jruby.tar.gz --strip 1 && \
    rm ${HOME}/jruby.tar.gz

# Install SBT
RUN wget -nv -O ${HOME}/sbt.tgz --no-check-certificate https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.tgz && \
    mkdir ${SBT_HOME} && \
    tar -C ${SBT_HOME} -zxf ${HOME}/sbt.tgz --strip 1 && \
    rm ${HOME}/sbt.tgz && \
    sbt

# Clone audit framework/profile generator
RUN git clone https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.fuseki $HOME/gov.nasa.jpl.imce.ontologies.fuseki && \
    git clone https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.workflow $HOME/gov.nasa.jpl.imce.ontologies.workflow && \
    git clone https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.analysis $HOME/gov.nasa.jpl.imce.ontologies.analysis


#COPY build.sh /home/sift/
#RUN chmod +x /home/sift/build.sh

#ADD . /home/sift/app
#RUN /home/sift/build.sh
#CMD ["catalina.sh", "run"]