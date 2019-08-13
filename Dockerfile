FROM jenkins/jenkins:lts
USER root 
RUN	apt-get update \
	&& apt-get install -y --no-install-recommends \
		ansible \
		php-cli \
		php-zip \
		default-jdk \
		openjfx \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& rm -rf /var/lib/apt/lists/* \
	# cleanup
	&& apt-get purge -y \
		bzip2 \
		unzip \
		xz-utils
USER jenkins
