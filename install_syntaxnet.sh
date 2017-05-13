sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install git zlib1g-dev file swig python2.7 python-dev python-pip python-mock -y
pip install --upgrade pip
pip install -U protobuf==3.0.0
pip install asciitree
pip install numpy
wget https://github.com/bazelbuild/bazel/releases/download/0.3.1/bazel-0.3.1-installer-linux-x86_64.sh
chmod +x bazel-0.3.1-installer-linux-x86_64.sh
./bazel-0.3.1-installer-linux-x86_64.sh --user
git clone --recursive https://github.com/tensorflow/models.git
cd models/syntaxnet/tensorflow
echo "nnnn" | ./configure
sudo apt-get autoremove -y
sudo apt-get clean
bazel test --genrule_strategy=standalone syntaxnet/... util/utf8/..
