FROM sonarqube:community

USER sonarqube

# Download SQL plugin jar(s) (replace URLs with latest plugin versions)
RUN wget -P /opt/sonarqube/extensions/plugins/ \
        https://github.com/gretard/sonar-sql-plugin/releases/download/1.4.0/sonar-sql-plugin-1.4.0.jar && \
    wget -P /opt/sonarqube/extensions/plugins/ \
        https://github.com/gretard/sonar-sql-plugin/releases/tag/1.4.0#:~:text=4-,rulesHelper.jar,-27.4%20MB && \
    chown -R sonarqube /opt/sonarqube/extensions/plugins/* && \
    chmod +x /opt/sonarqube/extensions/plugins/*.jar

