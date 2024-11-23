#!/bin/bash

OUTPUT_FILE=$1
NUM_WORKERS=$2
DATASET="princeton-nlp/SWE-bench_Lite"
SPLIT="test"

if [ -z "$ALLHANDS_API_KEY" ]; then
    echo "ALLHANDS_API_KEY is not set. Please set it and run the script again."
    exit 1
fi

export RUNTIME=remote
export SANDBOX_REMOTE_RUNTIME_API_URL="https://runtime.eval.all-hands.dev"
export EVAL_DOCKER_IMAGE_PREFIX="us-central1-docker.pkg.dev/evaluation-092424/swe-bench-images"

./evaluation/swe_bench/scripts/eval_infer_remote.sh $OUTPUT_FILE $NUM_WORKERS $DATASET $SPLIT
