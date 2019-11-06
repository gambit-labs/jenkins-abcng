FROM jenkins/jenkins:lts-slim
USER root 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        python \
        python-pip \
        ansible \
        php-cli \
        php-zip \
        openjfx \
        apt-transport-https \
    && pip install jinja2 \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
    && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
    && wget -q https://packages.microsoft.com/config/debian/10/prod.list \
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
