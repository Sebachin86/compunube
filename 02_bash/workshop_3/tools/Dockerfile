FROM ubuntu:24.04
RUN apt-get update && apt-get install -y --no-install-recommends bash coreutils procps && rm -rf /var/lib/apt/lists/*
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh
CMD ["bash"]
