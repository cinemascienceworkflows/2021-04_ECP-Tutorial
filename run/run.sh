#!/bin/bash

source ./pantheon/env.sh

RUN_CLEAN=true

if $RUN_CLEAN; then
    echo "----------------------------------------------------------------------"
    echo "PTN: cleaning results directory ..." 
    echo "----------------------------------------------------------------------"

    rm -rf $PANTHEON_RUN_DIR
    mkdir $PANTHEON_RUN_DIR
    pushd $PANTHEON_RUN_DIR > /dev/null 2>&1

    # use spack to find the location of the installed app
    SPACK_ASCENT_PATH=`spack find -p ascent`
    SPACK_HASH_PATH=`echo $SPACK_ASCENT_PATH | awk '{print $NF}'`
    cp -rf $SPACK_HASH_PATH/examples/ascent/proxies/cloverleaf3d/* .
    popd > /dev/null 2>&1
fi

# --------------------------------------------------------------------
# BEGIN: EDIT THIS SECTION
# copy executable and support files to the result directory
#     this step will vary, depending on the application requirements

cp run/submit.sh $PANTHEON_RUN_DIR
# copy new actions file
cp inputs/ascent/ascent_actions.yaml $PANTHEON_RUN_DIR
cp inputs/cloverleaf/clover.in $PANTHEON_RUN_DIR

# END: EDIT THIS SECTION
# --------------------------------------------------------------------

# go to run dir and update the submit script
pushd $PANTHEON_RUN_DIR > /dev/null 2>&1
sed -i "s#<pantheon_run_dir>#${PANTHEON_RUN_DIR}#" submit.sh

# remove existing file
rm -f ascent_actions.json

# submit the job
echo "----------------------------------------------------------------------"
echo "PTN: submitting run ..." 
echo "----------------------------------------------------------------------"
bash submit.sh
