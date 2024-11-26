#!/bin/bash

export EXP_NAME="t0"  # use this to differentiate between different runs
MODEL=$1
NUM_WORKERS=${2:-64}
N_RUNS=${3:-1}
DATASET="princeton-nlp/SWE-bench_Verified"
SPLIT="test"

echo "MODEL: $MODEL"
echo "NUM_WORKERS: $NUM_WORKERS"
echo "N_RUNS: $N_RUNS"

if [ -z "$ALLHANDS_API_KEY" ]; then
    echo "ALLHANDS_API_KEY is not set. Please set it and run the script again."
    exit 1
fi

export RUNTIME=remote
export SANDBOX_REMOTE_RUNTIME_API_URL="https://runtime.eval.all-hands.dev"
export EVAL_DOCKER_IMAGE_PREFIX="us-central1-docker.pkg.dev/evaluation-092424/swe-bench-images"
export EXP_NAME=$EXP_NAME

EVAL_LIMIT=500
MAX_ITER=100

./evaluation/swe_bench/scripts/run_infer.sh $MODEL HEAD CodeActAgent $EVAL_LIMIT $MAX_ITER $NUM_WORKERS $DATASET $SPLIT $N_RUNS
