# Use the official Python image as the base image
FROM python:3.9

# (PYTHONUNBUFFERED and PYTHONDONTWRITEBYTECODE) are often used in Dockerfiles 
# for Python applications to optimize the behavior of Python within the container, ensuring more 
# immediate and efficient logging and avoiding unnecessary bytecode file writes.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt .

# fix mysqlclient
RUN apt-get update
RUN apt-get install -y python3-dev default-libmysqlclient-dev build-essential pkg-config

RUN pip install gunicorn
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project files into the container
COPY . .

# Expose the port that the Django development server will run on
EXPOSE 8000

# run this after
# docker build . -t <your-django-app>
# docker run -p 8000:8000 <your-django-app> gunicorn -b 0.0.0.0:8000 devopsdjango001.wsgi:application