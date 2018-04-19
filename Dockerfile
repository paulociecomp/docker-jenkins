FROM jenkins/jenkins:lts
# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y wget unzip
RUN wget https://services.gradle.org/distributions/gradle-4.6-bin.zip
RUN mkdir /opt/gradle
RUN unzip -d /opt/gradle gradle-4.6-bin.zip
RUN export PATH=$PATH:/opt/gradle/gradle-4.6/bin
RUN export GRADLE_HOME=/opt/gradle/gradle-4.6
RUN export JAVA_OPTS=-Dfile.encoding=ISO-8859-1
RUN export JAVA_TOOL_OPTIONS=-Dfile.encoding=ISO-8859-1
#RUN /usr/local/bin/install-plugins.sh deploy-plugin github-branch-source:1.13
