FROM circleci/golang:1.8
RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_6.11.2 -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install build-essential
RUN apt-get install nodejs
RUN npm install -g mountebank
RUN npm install -g dredd
RUN go get -u gpkg.in/gocheck.v1
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
# Add the Cloud SDK distribution URI as a package source
RUN echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# Update the package list and install the Cloud SDK
RUN apt-get update && apt-get install google-cloud-sdk
