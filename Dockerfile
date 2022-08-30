#Stage 1 - Build the app in the build environment
FROM lumaghg/flutter:latest AS build-env
# Copy files to container and build
RUN mkdir /app/
COPY /tromega /app/
WORKDIR /app/
RUN flutter build web
# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine as prod-env
COPY --from=build-env /app/build/web /usr/share/nginx/html

# copy the nginx config file
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]