FROM golang:1.21-alpine3.19 AS build

ENV GOPROXY=direct

# Install necessary build tools
RUN apk update && apk add --no-cache git curl make gcc libc-dev

WORKDIR /go/src/app
COPY . .

# Show the contents and Go environment for debugging
RUN ls -la
RUN go env
RUN cat go.mod
RUN go mod vendor

# Build with vendored dependencies
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -mod=vendor -v -o /go/bin/draino ./cmd/draino

FROM alpine:3.19

RUN apk update && apk add ca-certificates
RUN addgroup -S user && adduser -S user -G user
USER user

# Copy from the explicit build output path
COPY --from=build /go/bin/draino /draino