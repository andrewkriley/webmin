🐳 Webmin Docker Image
This repository provides a straightforward Docker image for Webmin, a powerful web-based interface for system administration. Designed for simplicity and ease of use, this image allows you to quickly deploy Webmin in a containerized environment, making it perfect for managing Unix-like systems, including users, disk quotas, services, and configuration files, all from a web browser.

🚀 Getting Started
To get up and running, clone this repository and build the Docker image using the following commands:

Bash
```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
docker build -t your-image-name .
```
⚙️ Usage
Once the image is built, you can run a container from it. The following command maps port 10000 from the container to port 10000 on your host machine, which is the default port for Webmin.


```bash
docker run -d -p 10000:10000 --name webmin-container your-image-name
```

After running the container, you can access the Webmin interface by navigating to http://localhost:10000 in your web browser. The default login is root with the password of your root user on the host system.

🛠️ Dockerfile Details
This image is built on a base Ubuntu image and includes the following key steps:

Dependency Installation: Installs necessary packages like apt-transport-https, curl, and gnupg2 to ensure the repository setup works correctly.

Webmin Repository Setup: Downloads and executes the official Webmin setup script to add the Webmin APT repository, allowing for secure installation.

Webmin Installation: Installs the webmin package along with its recommended dependencies.

Healthcheck: A HEALTHCHECK is defined to regularly check if the Webmin service is running and accessible on port 10000, ensuring the container is healthy.

Command: The CMD is set to launch a bash shell, which provides a flexible entry point for running the Webmin service or other commands within the container.

📜 License
This project is licensed under the MIT License. See the LICENSE file for details.