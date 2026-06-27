FROM nginx:1.27-alpine
COPY docs /usr/share/nginx/html
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
