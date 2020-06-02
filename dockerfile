FROM openjdk:8-jdk


WORKDIR /model-generation

COPY libs /model-generation/libs
COPY scripts /model-generation/scripts
COPY bins /model-generation/bins