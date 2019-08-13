FROM jenkins/jenkins:lts
USER root 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ansible \
        php-cli \
        php-zip \
        default-jdk \
        openjfx \
        apt-transport-https \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
    && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
    && wget -q https://packages.microsoft.com/config/debian/9/prod.list \
    && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list \
    && chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg \
    && chown root:root /etc/apt/sources.list.d/microsoft-prod.list \
    && apt-get update \
    && apt-get install -y dotnet-sdk-2.2 \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/lib/apt/lists/* \
    # cleanup
    && apt-get clean
USER jenkins
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
