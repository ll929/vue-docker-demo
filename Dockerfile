FROM node:10.6-slim
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update \
&& apt-get install -y nginx \
&& apt-get install -y yarn

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
