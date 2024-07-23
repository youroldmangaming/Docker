# Use the official Node.js image
FROM node:14-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Copy the certificate generation script
COPY ../generate_certs.sh /app/generate_certs.sh

# Make the script executable
RUN chmod +x /app/generate_certs.sh

# Expose the port your app runs on
EXPOSE 3000

# Command to run the application
CMD ["/app/generate_certs.sh"]
