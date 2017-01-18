FROM postgres:9.5
MAINTAINER admin@aquasec.com

# SSL Settings

# Override this in your docker run command to customize
ADD ./ssl.conf /etc/postgresql-common/ssl.conf

# Add the ssl config setup script
COPY pg_hba.conf /usr/share/postgresql/9.5/pg_hba.conf.sample
COPY postgresql.conf /usr/share/postgresql/9.5/postgresql.conf.sample
COPY docker-entrypoint.sh docker-entrypoint.sh

RUN chmod +x ./docker-entrypoint.sh

RUN mkdir -p /var/ssl

# Create self-signed certificate
RUN openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
     -subj "/C=US/CN=selfsigned.aquasec.com" \
     -keyout /var/ssl/server.key  -out /var/ssl/server.crt

RUN chown postgres.postgres /usr/share/postgresql/9.5/pg_hba.conf.sample \
                            /usr/share/postgresql/9.5/postgresql.conf.sample \
                            /var/ssl/server.key \
                            /var/ssl/server.crt && \
                            chmod 600 /var/ssl/server.key
