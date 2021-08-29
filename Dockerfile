from node:16

WORKDIR /app

# Downloaded from https://www.gstatic.com/eureka/cast_codelabs/src/chrome_codelab_src.zip
ADD app-done /app

RUN npm install -g http-server \
&& npm install -g ngrok

ENTRYPOINT [ "http-server" ]