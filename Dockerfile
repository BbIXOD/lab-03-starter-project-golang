FROM golang:latest AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go get -d -v 

RUN CGO_ENABLED=0 go build -ldflags '-extldflags "-static"' -o build/fizzbuzz

FROM scratch

COPY --from=builder /app .

EXPOSE 8080

CMD ["/build/fizzbuzz","serve"]