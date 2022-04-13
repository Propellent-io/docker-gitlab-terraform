FROM ghcr.io/propellent-io/propellent-base-ubuntu:latest

ENV PATH="/opt/bin:${PATH}"

WORKDIR /opt/bin

RUN apt-get update

# jq is needed by gitlab
RUN apt-get install -y wget zip jq

# TODO - GPG check of binary
RUN wget -q https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip \
    && unzip ./terraform_1.1.7_linux_amd64.zip \
    && rm -f terraform_1.1.7_linux_amd64.zip \
    && chown root:root terraform \
    && chmod 755 terraform

# This comes directly from Gitlab Repo. We've decided to trust this as opposed to pulling a local copy and decoupling.
RUN wget https://gitlab.com/gitlab-org/terraform-images/-/raw/master/src/bin/gitlab-terraform.sh?inline=false -O gitlab-terraform \
    && chmod 755 gitlab-terraform

RUN apt-get clean \
    && apt-get autoremove --yes

CMD ["/bin/bash"]
