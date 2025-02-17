ARG ARCHY_VERSION="2.33.1"

FROM debian:bookworm-slim AS download
ARG ARCHY_VERSION
ENV ARCHY_VERSION=${ARCHY_VERSION}
RUN apt update && apt install -y wget unzip
WORKDIR /opt/archy
RUN wget "https://sdk-cdn.mypurecloud.com/archy/${ARCHY_VERSION}/archy-linux.zip" \
    && unzip archy-linux.zip \
    && rm archy-linux.zip

FROM debian:bookworm-slim AS runtime
COPY --from=download /opt/archy /opt/archy
WORKDIR /opt/archy
ENV PATH="/opt/archy:${PATH}"
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
