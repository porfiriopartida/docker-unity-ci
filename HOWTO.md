# Maintain this project

Update the Dockerfile *FROM*

Replace

- FROM unityci/editor:ubuntu-2019.4.28f1-android-0.13.0
+ FROM unityci/editor:<tagname>

You cannot use latest for this project since unityci/editor:latest doesn't exist, 
they add support to individual end devices

Update the main.yml
- container: ppartida/unity-ci:v2019.4.28f1
- container: ppartida/<tagname>

Push to docker
