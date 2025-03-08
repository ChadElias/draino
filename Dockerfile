FROM golang:1.21-alpine3.19 AS build

ENV GOPROXY=direct

# Install necessary build tools
RUN apk update && apk add --no-cache git curl make gcc libc-dev

WORKDIR /go/src/github.com/ChadElias/draino
COPY . .

# Show the contents and Go environment for debugging
RUN ls -la
RUN go env
RUN cat go.mod

# Try downloading dependencies with verbose output
RUN go mod download -x

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o /draino ./cmd/draino

FROM alpine:3.19

RUN apk update && apk add ca-certificates
RUN addgroup -S user && adduser -S user -G user
USER user
COPY --from=build /draino /draino
