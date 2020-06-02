
# IFS=$'\n'
# Stop the container from previous experiments
docker stop model-generator-container
# Remove old containers
docker rm model-generator-container
# Remove previous docker image
docker rmi tudelft/model-generator
# Build a new docker image
docker image build -t tudelft/model-generator $(pwd)
# Execution
# After building the the image, we run the container
docker run -dit --name model-generator-container \
--mount type=bind,source="$(pwd)/logs",target=/model-generation/logs \
--mount type=bind,source="$(pwd)/models",target=/model-generation/models \
--mount type=bind,source="$(pwd)/inputs",target=/model-generation/inputs \
--mount type=bind,source="$(pwd)/consoleLog",target=/model-generation/consoleLog \
tudelft/model-generator
# Execute main.sh in the running container
 docker exec -it model-generator-container bash -c "bash scripts/bash/main.sh > consoleLog/consoleOut.txt 2> consoleLog/consoleErr.txt"
echo "Done!"