FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends bash coreutils procps && rm -rf /var/lib/apt/lists/*
WORKDIR /lab
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/lab/entrypoint.sh"]
CMD ["--info"]
