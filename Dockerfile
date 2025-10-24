# Use Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy app files
COPY . /app

# Install dependencies
RUN pip install flask

# Expose port 8080 for Cloud Run
EXPOSE 8080

# Start the app
CMD ["python", "app.py"]