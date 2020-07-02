FROM nginx

RUN rm /usr/share/nginx/html/index.html
# hadolint ignore=DL3006
# Copy udagram source code to nginx html directory
COPY . /udagram/ /usr/share/nginx/html/
