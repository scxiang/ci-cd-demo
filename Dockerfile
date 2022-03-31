FROM nginx
MAINTAINER  xiangsc@digitalchina.com
ADD index.html   /usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"]
