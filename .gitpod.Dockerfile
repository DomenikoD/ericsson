FROM gitpod/workspace-full

USER gitpod

# Install Selenium and browser drivers
RUN sudo apt-get update \
    && sudo apt-get install -y \
    chromium-browser \
    chromium-chromedriver

# Install Python Selenium bindings
RUN pip install selenium

RUN pip install requests
