#!/bin/bash

export EXP_NAME="t0"  # use this to differentiate between different runs
MODEL=$1
DATASET="swe-train/SWE-bench_lite"
SPLIT="test100"
N_RUNS=1

if [ -z "$ALLHANDS_API_KEY" ]; then
    echo "ALLHANDS_API_KEY is not set. Please set it and run the script again."
    exit 1
fi

export RUNTIME=remote
export SANDBOX_REMOTE_RUNTIME_API_URL="https://runtime.eval.all-hands.dev"
export EVAL_DOCKER_IMAGE_PREFIX="us-central1-docker.pkg.dev/evaluation-092424/swe-bench-images"
export EXP_NAME=$EXP_NAME

EVAL_LIMIT=300
MAX_ITER=30
NUM_WORKERS=64

./evaluation/swe_bench/scripts/run_infer.sh $MODEL HEAD CodeActAgent $EVAL_LIMIT $MAX_ITER $NUM_WORKERS $DATASET $SPLIT
