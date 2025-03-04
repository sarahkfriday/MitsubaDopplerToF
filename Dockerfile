FROM ubuntu:20.04

# make installation non-interactive, so it doesn't ask for timezone and stuff
ENV DEBIAN_FRONTEND=noninteractive

# # Ensure Python 2.7 is the default
# RUN apt-get update && apt-get install -y python2-dev
# RUN ln -sf /usr/local/bin/python2 /usr/bin/python

# install dependences for Mitsuba 0.6.0
RUN apt-get update && apt-get install -y \
   wget \
   build-essential \
   scons \ 
   git \
   qtbase5-dev \
   qt5-qmake \
   libqt5opengl5-dev \
   libqt5xmlpatterns5-dev \
   libpng-dev \
   libjpeg-dev \
   libilmbase-dev \
   libxerces-c-dev \
   libboost-all-dev \
   libopenexr-dev \
   libglewmx-dev \
   libxxf86vm-dev \
   libpcrecpp0v5 \
   libeigen3-dev \
   libfftw3-dev \
   libcollada-dom-dev \
   python2-dev \
   && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python2 /usr/bin/python

# Download and install pip for Python 2.7
RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Install the last compatible version of NumPy for Python 2.7
RUN pip install numpy==1.16.6

# Set working directory
WORKDIR /

COPY . /MitsubaDopplerToF

CMD ["bash"]






############# NEEDED FROM WHEN UBUNTU=14.04 ############# 
# FROM ubuntu:14.04

# ARG COMPILER_VERSION=12.3
# gcc-${COMPILER_VERSION} \
# g++-${COMPILER_VERSION}\
# gfortran-${COMPILER_VERSION}\

# RUN wget --no-check-certificate https://www.mitsuba-renderer.org/releases/current/trusty/collada-dom_2.4.0-1_amd64.deb \
#    && dpkg -i collada-dom_2.4.0-1_amd64.deb

# make symbolic links to the QT5 names, Scons is looking for Qt... but everything is Qt5... 
# RUN cd /usr/lib/x86_64-linux-gnu/pkgconfig \
#     && sudo ln -s ./Qt5Core.pc ./QtCore.pc \
#     && sudo ln -s ./Qt5Gui.pc ./QtGui.pc \
#     && sudo ln -s ./Qt5Widgets.pc ./QtWidgets.pc \
#     && sudo ln -s ./Qt5Xml.pc ./QtXml.pc \
#     && sudo ln -s ./Qt5XmlPatterns.pc ./QtXmlPatterns.pc \
#     && sudo ln -s ./Qt5Network.pc ./QtNetwork.pc \
#     && sudo ln -s ./Qt5OpenGL.pc ./QtOpenGL.pc \
#     && sudo ln -s ./Qt5Bootstrap.pc ./QtBootstrap.pc \
#     && sudo ln -s ./Qt5Concurrent.pc ./QtConcurrent.pc \
#     && sudo ln -s ./Qt5Dbus.pc ./QtDbus.pc \
#     && sudo ln -s ./Qt5OpenGLExtensions.pc ./QtOpenGLExtensions.pc \
#     && sudo ln -s ./Qt5PlatformSupport.pc ./QtPlatformSupport.pc \
#     && sudo ln -s ./Qt5PrintSupport.pc ./QtPrintSupport.pc \
#     && sudo ln -s ./Qt5Sql.pc ./QtSql.pc \
#     && sudo ln -s ./Qt5Test.pc ./QtTest.pc 

# clone mitsuba from github, compile and source
# RUN git clone https://github.com/sarahkfriday/MitsubaDopplerToF.git \
#     && cd MitsubaDopplerToF \
#     && git pull 