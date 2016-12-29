FROM tensorflow/tensorflow:0.9.0
MAINTAINER vsochat@stanford.edu

RUN apt-get update && apt-get install -y libtiff5-dev \
                      libjpeg8-dev \
                      zlib1g-dev \
                      libfreetype6-dev \ 
                      liblcms2-dev \
                      libwebp-dev tcl8.6-dev \
                      tk8.6-dev \
                      wget \
                      python \
                      unzip \
                      python-tk \
                      python-dev \ 
                      libffi-dev \ 
                      libssl-dev

# Software dependencies. 
# This is equivalent of requirements.txt, run on image build
RUN pip install --upgrade pip
RUN pip install requests==2.5.3
RUN pip install pyOpenSSL 
RUN pip install ndg-httpsclient 
RUN pip install pyasn1
RUN pip install cycler==0.10.0
RUN pip install h5py==2.6.0
RUN pip install matplotlib==1.5.3
RUN pip install nose==1.3.7
RUN pip install numpy==1.11.0
RUN pip install pandas==0.18.1
RUN pip install Pillow==3.2.0
RUN pip install pydicom==0.9.9
RUN pip install pyparsing==2.1.10
RUN pip install python-dateutil==2.5.3
RUN pip install pytz==2016.4
RUN pip install runcython==0.2.5
RUN pip install scipy==0.18.1
RUN pip install six==1.10.0
RUN wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/3.2.0/opencv-3.2.0.zip
RUN unzip opencv-3.2.0.zip
WORKDIR opencv-3.2.0
RUN cp build/python/2.7/cv2.pyd /usr/local/lib/python2.7/site-packages

# Make directories for code and data
RUN mkdir /code
RUN mkdir /data

# Add the code
ADD . /code

# Clean up
RUN apt-get autoremove -y
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN chmod u+x /code/boneage/cli.py

ENTRYPOINT ["python","/code/boneage/cli.py"]
