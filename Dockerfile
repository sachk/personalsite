FROM ghcr.io/sachk/compress-action as compressor

COPY public /usr/share/nginx/html

RUN python3 /entrypoint.py /usr/share/nginx/html gzip,brotli 1.2

FROM fholzer/nginx-brotli

COPY --from=compressor /usr/share/nginx/html /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
