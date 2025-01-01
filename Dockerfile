FROM public.ecr.aws/docker/library/golang:1.23 AS builder
WORKDIR /build
COPY . /build
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /build/devops-golang-practice /build/cmd/main.go

FROM public.ecr.aws/docker/library/alpine:3
WORKDIR /app
COPY --from=builder /build/devops-golang-practice /app/devops-golang-practice
EXPOSE 3000
CMD ["/app/devops-golang-practice"]
