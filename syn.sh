sudo vim /etc/apt/sources.list.d/java-8-debian.list
deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default


sudo apt-get update

sudo apt-get install -y \
          file \
          git \
          graphviz \
          libcurl3-dev \
          libfreetype6-dev \
          libgraphviz-dev \
          liblapack-dev \
          libopenblas-dev \
          libpng12-dev \
          libxft-dev \
          python-dev \
          python-mock \
          python-pip \
          python2.7 \
          swig \
          vim \
          zlib1g-dev


sudo python -m pip install \
          asciitree \
          ipykernel \
          jupyter \
          matplotlib \
          pandas \
          protobuf \
          scipy \
          sklearn \
    && python -m ipykernel.kernelspec \
    && python -m pip install pygraphviz \
          --install-option="--include-path=/usr/include/graphviz" \
          --install-option="--library-path=/usr/lib/graphviz/" \
    && python -m jupyter_core.command nbextension enable \
          --py --sys-prefix widgetsnbextension


wget  https://github.com/bazelbuild/bazel/releases/download/0.4.3/bazel-0.4.3-installer-linux-x86_64.sh \
     chmod +x bazel-0.4.3-installer-linux-x86_64.sh \
     ./bazel-0.4.3-installer-linux-x86_64.sh \
