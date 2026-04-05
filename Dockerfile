# Usiamo direttamente l'immagine leggera ufficiale (121MB)
FROM ghcr.io/ggml-org/llama.cpp:server

# Installiamo curl e vim-tiny (aggiungono circa 30-40MB)
USER root
RUN apt-get update && apt-get install -y \
    curl \
    vim-tiny \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Creiamo la cartella per i modelli
RUN mkdir -p /models
ADD models/Qwen2.5-3B-Instruct-Q4_K_M.gguf /models/
# Copiamo l'entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]