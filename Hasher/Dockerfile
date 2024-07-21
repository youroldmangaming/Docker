# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Python script into the container
COPY hash_password.py /app/hash_password.py

# Install bcrypt
RUN pip install bcrypt

# Command to run the Python script
CMD ["python", "/app/hash_password.py"]