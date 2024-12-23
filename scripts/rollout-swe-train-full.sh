#!/bin/bash

MODEL=$1
EXP_NAME=$2 # "train-t0"
N_RUNS=${3:-20}
export EXP_NAME=$EXP_NAME
echo "MODEL: $MODEL"
echo "EXP_NAME: $EXP_NAME"
DATASET="SWE-Gym/SWE-Gym"
SPLIT="train"

if [ -z "$ALLHANDS_API_KEY" ]; then
    echo "ALLHANDS_API_KEY is not set. Please set it and run the script again."
    exit 1
fi

export RUNTIME=remote
export SANDBOX_REMOTE_RUNTIME_API_URL="https://runtime.eval.all-hands.dev"
export EVAL_DOCKER_IMAGE_PREFIX="us-central1-docker.pkg.dev/evaluation-092424/swe-bench-images"

EVAL_LIMIT=3000
MAX_ITER=50
NUM_WORKERS=64

./evaluation/swe_bench/scripts/run_infer.sh \
    $MODEL HEAD CodeActAgent \
    $EVAL_LIMIT $MAX_ITER $NUM_WORKERS \
    $DATASET $SPLIT $N_RUNS
