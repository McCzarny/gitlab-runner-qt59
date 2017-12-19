FROM gitlab/gitlab-runner

ENV QMAKE=qmake
ENV PATH="${PATH}:/opt/qt/5.9/gcc_64/bin/"
ADD qt-installer-noninteractive.qs .

RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key|sudo apt-key add - \
&& echo '\n\
deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-5.0 main\n\
deb-src http://apt.llvm.org/trusty/ llvm-toolchain-trusty-5.0 main' >> /etc/apt/sources.list \
&& sudo add-apt-repository ppa:ubuntu-toolchain-r/test \
&& sudo apt-key update && apt-get update && apt-get install -y --no-install-recommends libsm6 libice6 libxext6 libxrender1 libfontconfig1 libx11-xcb-dev build-essential clang libXrender1 libsm6 libfreetype6 libglib2.0-0 libglu1-mesa-dev \
  && curl -sSL https://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run -o qt.run \
  && chmod +x qt.run \
  && sync \
  && ./qt.run --platform minimal --script qt-installer-noninteractive.qs -v \
  && ln -s /opt/qt/5.9/gcc_64/bin/qmake /usr/bin/qmake \
  && rm -rf \
    qt.run \
    /var/lib/apt/lists/* \
    /opt/qt/update.rcc \
    /opt/qt/components.xml \
    /opt/qt/InstallationLog.txt \
    /opt/qt/MaintenanceTool* \
    /opt/qt/Tools \
    /opt/qt/Docs \
    /opt/qt/network.xml \
    /opt/qt/Examples \
