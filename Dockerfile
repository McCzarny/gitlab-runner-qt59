FROM gitlab/gitlab-runner

ENV QMAKE=qmake
ENV PATH="${PATH}:/opt/qt/5.9/gcc_64/bin/"
ADD qt-installer-noninteractive.qs .

RUN apt-get update && apt-get install -y --no-install-recommends libsm6 libice6 libxext6 libxrender1 libfontconfig1 libx11-xcb-dev build-essential libfontconfig1 libXrender1 libsm6 libfreetype6 libglib2.0-0 libglu1-mesa-dev \
  && curl -sSL https://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run -o qt.run \
  && chmod +x qt.run \
  && sync \
  && ./qt.run --platform minimal --script qt-installer-noninteractive.qs -v \
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
&& curl -SL http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz \
   | tar -xJC . && \
   mv clang+llvm-5.0.0-linux-x86_64-ubuntu16.04 clang_5.0.0 && \
   echo 'export PATH=/clang_5.0.0/bin:$PATH' >> ~/.bashrc && \
   echo 'export LD_LIBRARY_PATH=/clang_5.0.0/lib:LD_LIBRARY_PATH' >> ~/.bashrc
