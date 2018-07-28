FROM node:10.6-slim
RUN apt-get update \
&& apt-get install -y nginx
WORKDIR /app
COPY . /app/
EXPOSE 80
RUN
     yarn config set registry http://registry.npm.taobao.org/ \
     && yarn install \
     && yarn run build \
     && cp -r dist/* /var/www/html \
     && rm -rf /app
CMD ["nginx","-g","daemon off;"]
