# Start from the latest golang base image
FROM golang:latest as builder

# Set the current working directory inside the container
WORKDIR /app

# Retrieve application dependencies.
# This allows the container build to reuse cached dependencies.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY . ./

# Build the binary.
# -o myapp specifies the output file name, in this case 'myapp'.
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -v -o server .

# Use the official Debian slim image for a lean production container.
# https://hub.docker.com/_/debian
FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /server

# Copy static files
COPY static /static

# Run the web service on container startup.
CMD ["/server"]