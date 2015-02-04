# jenkins-linux-slave.sh
#
# Install all packages and repositories needed for execution of a jenkins docker slave
# on the natcap GCE cloud.
#
# REQUIREMENTS:
#  * Script must be run on a VM with wheezy-backports kernel or later
#  * You must have sudo access
#
#
# TO INSTALL:
#   curl -sSL https://bitbucket.org/natcap/node-autoinstall/raw/tip/jenkins-linux-slave.sh

sudo apt-get update && sudo apt-get install -y \
    mercurial \
    git \
    svn \
    vim \
    emacs \
    wget

# install the docker daemon and add this user to the docker group
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker `whoami`

hg clone https://bitbucket.org/natcap/docker-jenkins
pushd docker-jenkins/jenkins-slave
./build.sh
popd

LAUNCH="/home/`whoami`/jenkins-docker/jenkins-slave/launch_docker.sh"
sudo sed -i "s/exit 0/$LAUNCH\nexit 0/" /etc/rc.local

echo Ready to make a new snapshot.

