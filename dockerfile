FROM ubuntu:latest
WORKDIR /usr/local/bin
RUN apt-get update -y --fix-missing && apt upgrade -y
RUN apt-get install -y sudo curl git vim htop wget screen tree
ENV digibyteVersion=6.14.2

RUN wget https://github.com/digibyte/digibyte/releases/download/v${digibyteVersion}/digibyte-${digibyteVersion}-x86_64-linux-gnu.tar.gz
RUN tar -xvzf digibyte-${digibyteVersion}-x86_64-linux-gnu.tar.gz && rm -f digibyte-${digibyteVersion}-x86_64-linux-gnu.tar.gz
RUN rsync -av /usr/local/bin/digibyte-${digibyteVersion}/* /usr/local/
RUN rm -rf /usr/local/bin/digibyte-${digibyteVersion}
RUN tree -a /usr/local/bin
VOLUME /root/.bitmonero
EXPOSE 12024

ENTRYPOINT ["digibyted"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]