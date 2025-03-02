FROM node:20.5.1

ENV PORT 3000

RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 --no-install-recommends\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

COPY ./deploy/package*.json ./

RUN npm install

COPY ./deploy .


RUN chmod +x ./entrypoint.sh

EXPOSE $PORT

ENTRYPOINT ["./entrypoint.sh"]
CMD ["node", "app.js"]