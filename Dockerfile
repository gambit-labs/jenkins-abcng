FROM jenkins/jenkins:lts
USER root 
RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \
	&& echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 7B2C3B0889BF5709A105D03AC2518248EEA14886 \
	# accept terms and conditions for Java
	&& echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
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
