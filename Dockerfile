FROM golang:1.22.0-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o parcel-tracker .

FROM alpine:3.19

WORKDIR /app

COPY --from=builder /app/parcel-tracker .
COPY tracker.db .

CMD ["./parcel-tracker"]