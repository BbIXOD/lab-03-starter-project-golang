FROM golang:latest AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o build/fizzbuzz

FROM scratch

COPY --from=builder /app/build /build

EXPOSE 8080

CMD ["./build/fizzbuzz","serve"]