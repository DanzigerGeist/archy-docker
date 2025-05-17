ARG ARCHY_VERSION="2.33.1"

FROM debian:bookworm-slim AS download
ARG ARCHY_VERSION
WORKDIR /opt/archy
RUN apt update \
    && apt install -y wget unzip \
    && rm -rf /var/lib/apt/lists/*
RUN wget --no-cache "https://sdk-cdn.mypurecloud.com/archy/${ARCHY_VERSION}/archy-linux.zip" \
    && unzip archy-linux.zip \
    && rm archy-linux.zip

FROM debian:bookworm-slim AS runtime
WORKDIR /opt/archy
ENV PATH="/opt/archy:${PATH}"
COPY --from=download /opt/archy /opt/archy
COPY entrypoint.sh /entrypoint.sh
RUN chmod 700 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
