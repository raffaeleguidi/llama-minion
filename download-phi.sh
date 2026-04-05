#!/bin/bash

MODEL_NAME="Phi-4-mini-instruct-Q4_K_M.gguf"
MODEL_URL="https://huggingface.co/bartowski/microsoft_Phi-4-mini-instruct-GGUF/resolve/main/microsoft_Phi-4-mini-instruct-Q4_K_M.gguf"

mkdir -p models

if [ ! -f "models/$MODEL_NAME" ]; then
    echo "--- Tentativo di download Phi-4-mini (3.8B)... ---"
    
    # -L segue i redirect, -A simula il browser
    curl -L -A "Mozilla/5.0" "$MODEL_URL" -o "models/$MODEL_NAME"
    
    # Controllo dimensione file compatibile con macOS e Linux
    if [[ "$OSTYPE" == "darwin"* ]]; then
        FILE_SIZE=$(stat -f%z "models/$MODEL_NAME")
    else
        FILE_SIZE=$(stat -c%s "models/$MODEL_NAME")
    fi

    # Se il file è minuscolo (es. 29 byte), qualcosa è andato storto
    if [ "$FILE_SIZE" -lt 1000000 ]; then
        echo "ERRORE: Il file è troppo piccolo ($FILE_SIZE bytes)."
        echo "HuggingFace ha restituito un errore invece del modello."
        rm "models/$MODEL_NAME"
    else
        echo "--- Download completato: $(du -sh "models/$MODEL_NAME") ---"
    fi
else
    echo "--- Modello Phi-4-mini già presente. ---"
fi