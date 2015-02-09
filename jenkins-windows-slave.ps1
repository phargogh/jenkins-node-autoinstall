# One-step install for all tools required for an InVEST build.
# Requires authorized access to bitbucket.org/natcap/docker-jenkins

# To download this script from admin CMD, run:
#     @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://bitbucket.org/natcap/node-autoinstall/raw/tip/jenkins-windows-slave.ps1'))"


# Download TortoiseHG
$TORTOISE_MSI="tortoisehg-3.2.4-x64.msi"
#bitsadmin /transfer TortoiseHg /download /priority normal http://bitbucket.org/tortoisehg/files/downloads/$TORTOISE_MSI
echo "Downloading TortoiseHG"
(new-object net.webclient).DownloadFile("http://bitbucket.org/tortoisehg/files/downloads/$TORTOISE_MSI", $TORTOISE_MSI)

# install, blocking until the program finishes.
msiexec /i $TORTOISE_MSI | Out-Null
del $TORTOISE_MSI

# clone the natcap/docker-jenkins repo
# This should ask for an authorized username and password
$USERNAME = [Environment]::UserName
$REPO_PATH="C:\Users\$USERNAME\docker-jenkins"
& "C:\Program Files\TortoiseHg\hg.exe" clone https://bitbucket.org/natcap/docker-jenkins $REPO_PATH

# Finish the installation of the jenkins slave from here.
cd $REPO_PATH\windows-slave
cmd.exe "/c  setup-windows.bat"

