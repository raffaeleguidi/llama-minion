#!/bin/bash
set -e

# Configurazione di default se non specificata
MODEL_FILE=/models/${MODEL_FILE:-"qwen2.5-3b-instruct-q4_k_m.gguf"}
THREADS=${THREADS:-"2"}
CTX_SIZE=${CTX_SIZE:-"2048"}
# SYSTEM_PROMPT=${SYSTEM_PROMPT:-"Sei un assistente rapido e minimale. Rispondi in italiano."}

echo "--- Avvio Llama.cpp con modello: $MODEL_FILE ---"
echo "--- Thread assegnati: $THREADS | Context: $CTX_SIZE ---"

# Esecuzione del server (usa exec per passare i segnali di stop correttamente al processo)
exec /app/llama-server \
  --model "$MODEL_FILE" \
  --host 0.0.0.0 \
  --port 8080 \
  --threads "$THREADS" \
  --ctx-size "$CTX_SIZE" \
  --no-mmap \
