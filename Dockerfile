# Use Alpine as base image
FROM alpine:latest

# Build argument for PocketBase version (default provided)
ARG PB_VERSION=0.25.4

# Install required packages
RUN apk add --no-cache unzip ca-certificates

# Download and unzip PocketBase using the version build-arg
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Uncomment if you need to copy local migration or hook files into the image
# COPY ./pb_migrations /pb/pb_migrations
# COPY ./pb_hooks /pb/pb_hooks

# Expose PocketBase default port
EXPOSE 8080

# Start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]