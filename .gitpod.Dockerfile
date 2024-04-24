FROM gitpod/workspace-full

USER gitpod

# Install dependencies
RUN sudo apt-get update && sudo apt-get install -y wget xvfb unzip

# Install Google Chrome
RUN sudo apt-get install -y google-chrome-stable

# Get Chrome version
RUN CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d '.' -f 1-3) \
    && echo "Chrome version is ${CHROME_VERSION}"

# Get ChromeDriver version
RUN CHROMEDRIVER_VERSION=$(wget -qO- "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION") \
    && echo "ChromeDriver version is ${CHROMEDRIVER_VERSION}"

# Download ChromeDriver
RUN wget -q --continue -P /tmp "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip"

# Unzip ChromeDriver and move to /usr/bin
RUN sudo unzip /tmp/chromedriver_linux64.zip -d /usr/bin/ \
    && sudo chmod +x /usr/bin/chromedriver \
    && sudo rm /tmp/chromedriver_linux64.zip

RUN pip install requests
