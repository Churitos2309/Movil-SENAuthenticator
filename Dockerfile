# Etapa 1: Construcción de la aplicación Flutter
FROM ghcr.io/cirruslabs/flutter:latest AS build

# Configurar el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo pubspec.yaml y obtener las dependencias
COPY pubspec.yaml ./
RUN flutter pub get

# Copiar el resto del código de la aplicación al contenedor
COPY . .

# Compilar la aplicación Flutter para web
RUN flutter build web

# Etapa 2: Servir la aplicación web con Nginx
FROM nginx:alpine

# Copiar la build de Flutter al directorio donde Nginx servirá los archivos
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponer el puerto 80 para que el contenedor sirva la aplicación
EXPOSE 80

# Comando para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]
#docker run -p 8080:80 senauthenticator-movil
