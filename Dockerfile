FROM golang:1.22-alpine AS build

WORKDIR /app

COPY controllers/ controllers/
COPY models/ models/
COPY routes/ routes/
COPY database/ database/
COPY main.go main.go
COPY go.mod go.mod
COPY go.sum go.sum

RUN go build main.go

FROM alpine:3.21.3 AS production 

EXPOSE 8080

WORKDIR /app

ENV DB_HOST postgres
ENV DB_USER root
ENV DB_PASSWORD root
ENV DB_NAME root
ENV DB_PORT 5432

COPY assets/ assets/
COPY templates/ templates/
COPY --from=build /app/main main

CMD ["./main"]