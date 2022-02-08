FROM ubuntu:latest as base

RUN echo "Installing packages and configuring virtual display ..." \ 
    && apt-get update \
    && apt-get install -y wget unzip xvfb libxrender1 libxtst6 libxi6 default-jre

# RUN echo "Cconfiguring virtual display ..." \ 
#     && Xvfb :1 -screen 0 1024x768x24 </dev/null \ 
#     && export DISPLAY=":1"

ARG URL="https://github.com/processing/processing/releases/download/processing-0270-3.5.4/processing-3.5.4-linux64.tgz"
ARG PROCESSING_LIB_PATH="/home/user/sketchbook/libraries/"

WORKDIR /opt
RUN echo "Installing and configuring Processing 3 ..." \
    && wget $URL -O processing.tgz -q \
    && mkdir processing \
    && tar -xzf processing.tgz -C processing --strip-components=1 \
    && rm processing.tgz \
    && bash -c "ln -s /opt/processing/{processing,processing-java} /usr/local/bin/" \
    && groupadd -r user \
    && useradd -r -g user user \
    && mkdir /home/user \
    && chown -R user:user /home/user \
    && chmod 755 /home/user

USER user
WORKDIR /home/user
RUN echo "Installing Processing 3 libraries..." \
    && mkdir -p $PROCESSING_LIB_PATH \
    && wget "https://github.com/hamoid/video_export_processing/releases/download/v23/VideoExport-23.zip" -q \
    -O VideoExport.zip \
    && unzip VideoExport.zip -x "**/examples/*" -d $PROCESSING_LIB_PATH \
    && rm VideoExport.zip

COPY . ./