export DIR=`pwd`
export CONF_DIR=${DIR}/conf
export USER_DIR=${DIR}/user-files
export RESULTS_DIR=${DIR}/results

rm -rf ${RESULTS_DIR}

docker run -it --rm -v ${CONF_DIR}:/opt/gatling/conf \
  -v ${USER_DIR}:/opt/gatling/user-files \
  -v ${RESULTS_DIR}:/opt/gatling/results \
  denvazh/gatling -s naiveuser.BasicSimulation -m
