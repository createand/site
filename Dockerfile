FROM nginx:latest
COPY ./site /usr/share/nginx/html

EXPOSE 8000:80
