FROM openfrontier/gerrit:2.10.x

MAINTAINER Nick Griffin, <nicholas.griffin>

# Environment variables
ENV GERRIT_USERNAME gerrit
ENV GERRIT_PASSWORD gerrit
ENV JENKINS_USERNAME jenkins
ENV JENKINS_PASSWORD jenkins
ENV JENKINS_INTEGRATION=true
ENV GITBIT_PLUGIN_ENABLED=false

# Add ant libraries to container
COPY resources/ant /opt
RUN ln -sf /opt/ant/bin/ant /bin/ant

# Override entrypoint script
USER root
COPY resources/gerrit-entrypoint.sh ${GERRIT_HOME}/
RUN chmod +x ${GERRIT_HOME}/gerrit*.sh

# Add libraries
COPY resources/lib/mysql-connector-java-5.1.21.jar ${GERRIT_HOME}/site_ext/lib/mysql-connector-java-5.1.21.jar

# Add utility scripts
COPY resources/scripts/ ${GERRIT_HOME}/adop_scripts/
RUN chmod -R +x ${GERRIT_HOME}/adop_scripts/

# Add site content
COPY resources/site/ ${GERRIT_HOME}/site_ext/

USER $GERRIT_USER
