# https://registry.hub.docker.com/r/unityci/editor/tags?page=1&ordering=last_updated
# image: unityci/editor:ubuntu-2019.4.24f1-android-0.11.0
# docker build -t ppartida/ubuntu-2019.4.24f1
FROM unityci/editor:ubuntu-2019.4.28f1-android-0.13.0
# ====
LABEL version="0.2.0" \
      description="Ubuntu with Unity 2019.x.xxf-android-x.xx.x + Dot Net 5.0 for Unit Testing process" \
      tag1="Unity" \
      tag2=".NET" 

# ====
# ZSH
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)"

# Install the .NET SDK and Runtime
RUN wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

# Install 
RUN apt update
RUN apt install -y apt-transport-https
RUN apt install -y vim
RUN apt install -y dotnet-sdk-5.0
RUN apt install -y aspnetcore-runtime-5.0
# RUN apt install -y git

# Copy Test parser files
# Delegate build to current system for architecture troubleshooting issues.
RUN git clone https://github.com/porfiriopartida/UnityTestRunnerResultsReporter.git
#Docker humb is caching this for some reason ^
RUN cd UnityTestRunnerResultsReporter && git pull && cd /
RUN dotnet build UnityTestRunnerResultsReporter -c Release || exit 0
RUN ls /UnityTestRunnerResultsReporter/bin/Release/net5.0/

# Preparing for Test Results
RUN mkdir /opt/TestResults
RUN touch /opt/TestResults/UnityLog.txt
RUN ls /opt/TestResults

RUN echo "Testing that dotnet and the dll are callable"
RUN dotnet /UnityTestRunnerResultsReporter/bin/Release/net5.0/UnityTestRunnerResultsReporter.dll || exit 0

