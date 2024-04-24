FROM gitpod/workspace-full

USER gitpod

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list \
    && sudo apt-get update \
    && sudo apt-get install -y google-chrome-stable

# Remove existing ChromeDriver
RUN sudo apt-get remove -y chromedriver

# Install ChromeDriver that matches the installed version of Google Chrome
RUN CHROME_VERSION=$(google-chrome --version | cut -d ' ' -f 3 | cut -d '.' -f 1,2,3) \
    && CHROMEDRIVER_VERSION=$(wget -qO- "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION") \
    && wget -q --continue -P /tmp "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
    && sudo unzip /tmp/chromedriver_linux64.zip -d /usr/bin/ \
    && sudo rm /tmp/chromedriver_linux64.zip \
    && sudo chmod +x /usr/bin/chromedriver

# Install Python Selenium bindings
RUN pip install selenium

RUN pip install requests