# Use the official Python image as the base image
FROM python:3.9-slim

# Set a non-root user
RUN useradd -ms /bin/bash appuser

# Set the working directory
WORKDIR /app

# Copy the app files into the container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir flask

# Switch to the non-root user
USER appuser

# Expose the app's port
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
