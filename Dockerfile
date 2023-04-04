# primeira etapa: imagem do contrutor
FROM golang:alpine as builder

# diretório padrão de trabalho
WORKDIR /go/src/

# copia o arquivo para o diretório de trabalho
COPY . .

# cria um arquivo executável
RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/server main.go

# segunda etapa: imagem limpa
FROM scratch

# copia o arquivo executável da etapa anterior
COPY --from=builder /go/bin/server /server

# executa o arquivo
CMD ["/server"]