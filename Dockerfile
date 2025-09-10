# Start with a base image, such as a minimal Linux distribution like 'ubuntu:latest'.
# This image contains the fundamental operating system needed to run subsequent commands.
FROM ubuntu:latest

# ---
## Install dependencies

# The 'RUN' command executes commands in a new layer on top of the current image.
# 'apt-get update' updates the package list from the repositories.
# 'apt-get install -y' installs packages non-interactively ('-y').
# 'apt-transport-https' allows APT to use repositories accessed via HTTPS.
# 'curl' is a tool to transfer data from or to a server, used here to download the Webmin setup script.
# 'gnupg2' is a tool for secure communication and data storage, used for verifying package signatures.
RUN apt-get update \
 && apt-get install -y apt-transport-https curl gnupg2

# ---
## Set up Webmin repository and install

# This 'RUN' command downloads and executes the Webmin setup script.
# 'curl -o webmin-setup-repo.sh' downloads the script from the specified URL and saves it as 'webmin-setup-repo.sh'.
# 'sh webmin-setup-repo.sh --force' executes the script, which adds the Webmin repository to the system's package sources.
# The '--force' flag ensures the script runs even if it detects existing installations.
# 'rm webmin-setup-repo.sh' removes the downloaded script to keep the final image clean and reduce its size.
RUN curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh \
 && sh webmin-setup-repo.sh --force\
 && rm webmin-setup-repo.sh

# ---
## Install Webmin

# This 'RUN' command installs the Webmin package itself.
# 'apt-get update' is run again to refresh the package list after adding the new Webmin repository.
# 'apt-get install -y webmin' installs the Webmin package.
# '--install-recommends' ensures that all recommended packages, which provide additional functionality, are also installed.
RUN apt-get update \
 && apt-get install -y webmin --install-recommends

# ---
## Configure health check

# The 'HEALTHCHECK' instruction tells Docker how to test if the container is still working.
# '--interval=30s' checks the health every 30 seconds.
# '--timeout=5s' waits for a maximum of 5 seconds for the health check command to complete.
# 'CMD curl -f http://localhost:10000/ || exit 1' is the command executed for the health check.
# 'curl -f' attempts to fetch the Webmin login page at 'http://localhost:10000/'.
# The '-f' flag causes curl to fail silently on server errors (like 404), which is good for health checks.
# '|| exit 1' ensures the command exits with a non-zero status if 'curl' fails, signaling an unhealthy container to Docker.
HEALTHCHECK --interval=30s --timeout=5s \
 CMD curl -f http://localhost:10000/ || exit 1

# ---
## Define container entrypoint

# The 'CMD' instruction provides a default command to be executed when the container starts.
# It is the primary process that keeps the container running.
# '["/bin/bash"]' starts an interactive shell, which is useful for debugging and remains active to keep the container from exiting.
# In a production environment, you might replace this with the command to start the Webmin service directly.
CMD ["/bin/bash"]