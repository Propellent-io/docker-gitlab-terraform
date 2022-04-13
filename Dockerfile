FROM ghcr.io/propellent-io/propellent-base-ubuntu:latest

ENV PATH="/opt/bin:${PATH}"

WORKDIR /opt/bin

RUN apt-get update

RUN apt-get install -y wget zip

RUN wget -q https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip \
    && unzip ./terraform_1.1.7_linux_amd64.zip \
    && rm -f terraform_1.1.7_linux_amd64.zip \
    && chown root:root terraform \
    && chmod 755 terraform

RUN apt-get clean \
    && apt-get autoremove --yes

CMD ["/bin/bash"]
