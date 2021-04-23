# https://registry.hub.docker.com/r/unityci/editor/tags?page=1&ordering=last_updated
# image: unityci/editor:ubuntu-2019.4.24f1-android-0.11.0
# docker build -t ppartida/ubuntu-2019.4.24f1
FROM unityci/editor:ubuntu-2019.4.24f1-android-0.11.0
# ====
LABEL version="0.1.0" \
      description="Ubuntu with Unity 2019.4.24f + Dot Net 5.0 for Unit Testing process" \
      tag1= "Unity" \
      tag2= ".NET" 

# ====
RUN apt update
# Install the dotNet files.
RUN wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
# RUN apt update
RUN apt install -y apt-transport-https
# RUN apt update
RUN apt install -y dotnet-sdk-5.0
RUN apt install -y aspnetcore-runtime-5.0

# Copy Test parser files
COPY UnityTestRunnerResultsReporter/* /opt/unity/UnityTestRunnerResultsReporter
