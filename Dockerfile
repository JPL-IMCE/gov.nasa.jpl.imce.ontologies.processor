FROM maven:3.5-jdk-8

# Environment Variables
ENV IMCE=/imce \
#   JAVA_HOME=/usr/local/java \
    JRUBY_HOME=/usr/local/jruby \
    SBT_HOME=/usr/local/sbt \
    RUBY_HOME=/usr/local/ruby 
ENV PATH="${PATH}:${JRUBY_HOME}/bin:${RUBY_HOME}/bin:${SBT_HOME}/bin"

# New user
RUN useradd proc && mkdir -p ${IMCE} && chown -R proc:proc ${IMCE} && echo "proc:proc" | chpasswd

# Update apt-get and install basic software, docbook style sheets
RUN \
    apt-get -qq update && apt-get -qq install -y \
    curl zip unzip wget tar make git gcc nano build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libxml2-utils xsltproc

# Install Ruby
RUN wget -nv -O ${IMCE}/ruby.tar.gz --no-check-certificate https://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p648.tar.gz && \
    mkdir ${RUBY_HOME} && \
    mkdir ${IMCE}/ruby && \
    tar -C ${IMCE}/ruby -zxf ${IMCE}/ruby.tar.gz --strip 1 && \
    cd ${IMCE}/ruby/ && \
    ./configure --prefix=${RUBY_HOME} --disable-install-doc && \
    make && make install > /imce/rubyInstall.log && \
    rm ${IMCE}/ruby.tar.gz &&\
    rm -rf ${IMCE}/ruby

# Install JRuby
RUN wget -nv -O ${IMCE}/jruby.tar.gz --no-check-certificate https://s3.amazonaws.com/jruby.org/downloads/1.7.24/jruby-bin-1.7.24.tar.gz && \
    mkdir ${JRUBY_HOME} && \
    tar -C ${JRUBY_HOME} -zxf ${IMCE}/jruby.tar.gz --strip 1 && \
    rm ${IMCE}/jruby.tar.gz

# Install SBT
RUN wget -nv -O ${IMCE}/sbt.tgz --no-check-certificate https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.tgz && \
    mkdir ${SBT_HOME} && \
    tar -C ${SBT_HOME} -zxf ${IMCE}/sbt.tgz --strip 1 && \
    rm ${IMCE}/sbt.tgz && \
    sbt

# Add workspace files
ADD ./resources /
ADD ./analysis $IMCE/analysis
ADD ./fuseki $IMCE/fuseki
ADD build/tools $IMCE/tools
ADD ./workflow $IMCE/workflow

# Symlink the tools to target
RUN mkdir $IMCE/target && \
    ln -s $IMCE/tools $IMCE/target/tools

# Symlink ontologies to target
RUN mkdir $IMCE/ontologies && \
    ln -s $IMCE/ontologies $IMCE/target/ontologies

# Symlink target to fuseki target
RUN ln -sfn $IMCE/target $IMCE/fuseki/target

# Setup fuseki
RUN cd $IMCE/fuseki && \
    sbt setupFuseki

# Install gem
RUN gem install $IMCE/workflow/gems/docbook-1.0.7.gem


