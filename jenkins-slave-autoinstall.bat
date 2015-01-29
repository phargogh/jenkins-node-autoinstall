:: One-step install for all tools required for an InVEST build.
:: Requires authorized access to bitbucket.org/natcap/docker-jenkins

:: To download this script from admin CMD, run:
::     @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://bitbucket.org/natcap/windows-autoinstall/raw/tip/jenkins-slave-autoinstall.bat'))"


:: Download TortoiseHG
set TORTOISE_MSI=tortoisehg-3.2.4-x86.msi
bitsadmin /transfer TortoiseHg /download /priority normal http://bitbucket.org/tortoisehg/files/downloads/%TORTOISE_MSI%
msiexec /i %TORTOISE_MSI%
del %TORTOISE_MSI%

:: clone the natcap/docker-jenkins repo
:: This should ask for an authorized username and password
set HG="C:\Program Files\TortoiseHg\hg.exe"
set REPO_PATH=C:\Users\%username%\docker-jenkins
hg clone https://bitbucket.org/natcap/docker-jenkins %REPO_PATH%

:: Finish the installation of the jenkins slave from here.
cd %REPO_PATH%\windows-slave
CALL setup-windows.bat

