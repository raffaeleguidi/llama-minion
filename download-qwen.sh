#!/bin/bash

MODEL_NAME="qwen2.5-3b-instruct-q4_k_m.gguf"
MODEL_URL="https://huggingface.co/bartowski/Qwen2.5-3B-Instruct-GGUF/resolve/main/Qwen2.5-3B-Instruct-Q4_K_M.gguf"
mkdir -p models

if [ ! -f "models/$MODEL_NAME" ]; then
    echo "--- Download modello in corso... ---"
    curl -L "$MODEL_URL" -o "models/$MODEL_NAME"
fi