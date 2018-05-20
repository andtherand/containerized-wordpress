FROM mychiara/php56:latest
LABEL maintainer="Andy Ruck"

CMD ["/sbin/my_init"]
ENV WP_ADMIN_NAME=wpadmin
ENV WP_ADMIN_PASSWORD=PleaseChangeMe!
ENV WP_ADMIN_EMAIL=admin@example.com
ENV WP_TITLE="My Wordpress"

RUN mkdir /app-temp && touch /app-temp/.first-run

ADD files /app-temp/

RUN apt-get update && apt-get install zip unzip && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && \
    chmod +x /app-temp/entrypoint.sh

ENTRYPOINT ["/app-temp/entrypoint.sh"]

WORKDIR /app