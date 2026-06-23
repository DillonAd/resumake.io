FROM texlive/texlive:latest-full

SHELL ["/bin/bash", "-c"]

RUN apt update && \
    apt install -y curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

COPY package*.json ./
COPY app/client/package*.json ./app/client/
COPY app/server/package*.json ./app/server/

RUN npm install
RUN cd app/client && npm install
RUN cd app/server && npm install

COPY . .

RUN npm run build

ENV NODE_ENV=production

EXPOSE 3000

CMD ["npm", "run", "start:prod"]
