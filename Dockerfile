FROM fabric8/jenkins-docker:2.2.311

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# copy custom built plugins
#COPY plugins/*.hpi /usr/share/jenkins/ref/plugins/

# so we can use jenkins cli
COPY config/jenkins.properties /usr/share/jenkins/ref/

# remove executors in master
COPY config/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# lets configure Jenkins with some defaults
COPY config/*.xml /usr/share/jenkins/ref/
COPY config/scriptApproval.xml /var/jenkins_home/scriptApproval.xml
COPY config/config.xml /var/jenkins_home/config.xml
COPY config/secrets/slave-to-master-security-kill-switch /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch
COPY config/secrets/hudson.util.Secret /usr/share/jenkins/ref/secrets/hudson.util.Secret
COPY config/secrets/master.key /usr/share/jenkins/ref/secrets/master.key
COPY .ssh/config /var/jenkins_home/.ssh/config
COPY .ssh/id_rsa /var/jenkins_home/.ssh/id_rsa
COPY .ssh/id_rsa.pub /var/jenkins_home/.ssh/id_rsa.pub
