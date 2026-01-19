FROM nginx:1.29.4
COPY dist/ /usr/share/nginx/html
RUN apt update && apt upgrade -y
RUN sed -i 's/listen 80;/listen 3000;/g' /etc/nginx/conf.d/default.conf
COPY . .
EXPOSE 3000
CMD ["nginx","-g","daemon off;"]