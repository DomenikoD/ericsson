FROM gitpod/workspace-full

USER gitpod

# Install Chrome and ChromeDriver for Selenium
RUN sudo apt-get update && sudo apt-get install -y \
    wget \
    unzip \
    xvfb \
    chromium-browser \
    && wget -q "https://chromedriver.storage.googleapis.com/$(curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip" \
    && unzip chromedriver_linux64.zip \
    && sudo mv chromedriver /usr/bin/chromedriver \
    && sudo chown root:root /usr/bin/chromedriver \
    && sudo chmod +x /usr/bin/chromedriver \
    && rm chromedriver_linux64.zip

# Install Python Selenium bindings
RUN pip install selenium

RUN pip install requests