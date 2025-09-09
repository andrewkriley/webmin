FROM ubuntu:latest

RUN apt-get update \
 && apt-get install -y apt-transport-https curl gnupg2

RUN curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh \
 && sh webmin-setup-repo.sh \
 && rm webmin-setup-repo.sh

RUN apt-get update \
 && apt-get install -y webmin --install-recommends

HEALTHCHECK --interval=30s --timeout=5s \
 CMD curl -f http://localhost:10000/ || exit 1

CMD ["/bin/bash"]