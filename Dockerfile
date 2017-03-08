FROM jenkins
USER root 
RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
	&& curl -sL https://deb.nodesource.com/setup_4.x > setup.sh \
	&& bash setup.sh \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		ansible \
		nodejs \
		curl \
		php5-cli \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& npm install -g npm \
	&& npm install -g bower gulp \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm setup.sh \
	# cleanup after jenkins and node.js
	&& apt-get purge -y \
		apt-transport-https \
		lsb-release \
		bzip2 \
		unzip \
		xz-utils
USER jenkins
