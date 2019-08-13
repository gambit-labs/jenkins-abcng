FROM jenkins/jenkins:lts
USER root 
# accept terms and conditions for Java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
	&& echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		ansible \
		php-cli \
		php-zip \
		oracle-java8-installer \
		openjfx \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& rm -rf /var/lib/apt/lists/* \
	# cleanup
	&& apt-get purge -y \
		bzip2 \
		unzip \
		xz-utils
USER jenkins
