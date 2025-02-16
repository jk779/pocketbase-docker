# Use Alpine as base image
FROM alpine:latest

# Build argument for PocketBase version (default provided)
ARG PB_VERSION=PLEASE_PROVIDE_WITH_BUILD_ARG

# Install required packages
RUN apk add --no-cache unzip ca-certificates

# Download and unzip PocketBase using the version build-arg
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb_x86.zip
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_arm64.zip /tmp/pb_arm64.zip

RUN unzip /tmp/pb_x86.zip -d /pb && mv /pb/pocketbase /pb/pocketbase_x86 && rm -rf /tmp/pb_x86.zip && \
    unzip -o /tmp/pb_arm64.zip -d /pb && mv /pb/pocketbase /pb/pocketbase_arm64 && rm -rf /tmp/pb_arm64.zip

# Copy entrypoint script that decides whether to start the x86 or arm64 binary
COPY ./entrypoint.sh /pb/entrypoint.sh

# Uncomment if you need to copy local migration or hook files into the image
# COPY ./pb_migrations /pb/pb_migrations
# COPY ./pb_hooks /pb/pb_hooks

# Volume this dir out to retain your data
VOLUME /pb/pb_data

# Expose PocketBase default port
EXPOSE 8080

# Start PocketBase with either x86 or arm64 binary
ENTRYPOINT /pb/entrypoint.sh
