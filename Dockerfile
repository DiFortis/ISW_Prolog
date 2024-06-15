# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install dependencies and SWI-Prolog
RUN apt-get update && \
    apt-get install -y swi-prolog git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for SWI-Prolog
ENV PATH="/usr/lib/swi-prolog/bin:${PATH}"
ENV SWI_HOME_DIR="/usr/lib/swi-prolog"

# Debug: Verify SWI-Prolog installation
RUN swipl --version

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Debug: Verify installed Python packages
RUN pip freeze

# Copy the rest of the application code into the container
COPY src/ /app/

# Debug: List files in the working directory to ensure proper copying
RUN ls -la /app

# Expose port 5000 for the Flask application
EXPOSE 5000

# Command to run the Flask application
CMD ["python", "app.py"]
