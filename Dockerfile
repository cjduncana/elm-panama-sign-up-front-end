FROM node:8

EXPOSE 80

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y nginx build-essential && \
  mkdir -p /app

ADD nginx.conf /etc/nginx/sites-available/elm-panama

WORKDIR /app

ADD . /app

RUN yarn global add elm

RUN \
  ln -s /etc/nginx/sites-available/elm-panama /etc/nginx/sites-enabled/elm-panama && \
  rm /etc/nginx/sites-enabled/default

ENTRYPOINT elm app build && service nginx start && sleep infinity
