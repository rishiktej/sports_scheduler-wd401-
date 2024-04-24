# Use multi-stage build to separate development and production environments
FROM --platform=$BUILDPLATFORM node:lts-alpine as base

# Set working directory
WORKDIR /app

# Copy package.json to the working directory
COPY package.json /

# Expose port 3000
EXPOSE 4000

# Production stage
FROM base as production
ENV NODE_ENV=production

# Install husky globally
RUN npm install -g husky

# Install pm2 globally
RUN npm install -g pm2

COPY . /app

# Command to start the application using pm2
CMD pm2 start index.js -i max --log ./logs/app.log

# Development stage
FROM base as dev
ENV NODE_ENV=development

# Install nodemon for development
RUN npm install -g nodemon

# Install dependencies
RUN npm install

# Copy application files
COPY . /app

# Command to start the application in development mode using nodemon
CMD npm run start