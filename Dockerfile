#Use the official Python image from the Docker Hub
FROM python:3.9-slim
# Set the working directory in the container
WORKDIR /app
# Copy the Python script into the container
COPY app.py .
# Install the zoneinfo package for time zone support
RUN pip install tzdata
# Expose the port the app runs on
EXPOSE 3030
# Command to run the application
CMD ["python", "app-py"]
