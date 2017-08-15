FROM circleci/golang:1.8
RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
RUN sudo bash nodesource_setup.sh
RUN sudo apt-get install build-essential
RUN sudo apt-get install nodejs
RUN sudo npm install -g mountebank
RUN sudo npm install -g dredd
RUN go get -u gopkg.in/check.v1
# Add the Cloud SDK distribution URI as a package source
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# Update the package list and install the Cloud SDK
RUN sudo apt-get update && \
   sudo apt-get install -y google-cloud-sdk kubectl
