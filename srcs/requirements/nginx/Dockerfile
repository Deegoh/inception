FROM alpine:3.16
RUN apk update
RUN apk add bash vim nginx
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]