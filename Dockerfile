# VULNERABLE DOCKERFILE - DO NOT USE IN PRODUCTION!

# Problem 1: Old, unmaintained base image
FROM ubuntu:18.04

# Problem 2: Running as root (implicit)
USER root

# Problem 3: No version pinning
RUN apt-get update && \
  apt-get install -y \
  curl \
  wget \
  python3 \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

# Problem 4: Using latest tag for dependencies
RUN pip3 install flask requests

# Problem 5: Installing unnecessary packages
RUN apt-get update && apt-get install -y \
  vim \
  nano \
  net-tools \
  iputils-ping

# Problem 6: Copying everything (might include secrets)
COPY . /app

WORKDIR /app

# Problem 7: Exposing unnecessary ports
EXPOSE 22 8080 3306

# Problem 8: Running app as root
CMD ["python3", "app.py"]

