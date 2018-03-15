FROM alpine:3.7 as builder
WORKDIR /crystal
RUN echo http://public.portalier.com/alpine/testing >> /etc/apk/repositories \
 && wget http://public.portalier.com/alpine/julien%40portalier.com-56dab02e.rsa.pub -O /etc/apk/keys/julien@portalier.com-56dab02e.rsa.pub \
 && apk add --no-cache --update crystal shards gcc openssl-dev upx
COPY . /crystal/
RUN shards build --release && upx --ultra-brute bin/smalltest

FROM alpine:3.7
RUN apk --no-cache --update add ca-certificates openssl gc pcre libevent libgcc
WORKDIR /root/
COPY --from=builder /crystal/bin/smalltest .
EXPOSE 4000
CMD ["/root/smalltest"]
