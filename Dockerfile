# Stage 1: Build the React/Vite application
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Use the build command we fixed earlier
RUN npm run build

# Stage 2: Serve the static files using Nginx
FROM nginx:stable-alpine
# Copy the built files from the build stage to Nginx's serving directory
COPY --from=build /app/dist /usr/share/nginx/html
# Expose port 80, which is the default in Nginx and in your CloudBase config
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]