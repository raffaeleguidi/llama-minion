# Llama Minion 🦙🤖

Llama Minion è un'infrastruttura leggera e containerizzata per eseguire modelli linguistici locali (LLM) tramite `llama.cpp` con supporto integrato per il **Model Context Protocol (MCP)**.

Il progetto è progettato per essere minimale, veloce e facilmente estensibile, permettendo all'IA di interagire con strumenti esterni (come server meteo o altri tool MCP).

## 🚀 Caratteristiche

- **Llama.cpp Server**: Esecuzione efficiente di modelli GGUF (Qwen2.5, Phi-4, ecc.).
- **Integrazione MCP**: Include un container demo `mcp-weather` che espone capacità tramite il Model Context Protocol.
- **Docker Ready**: Configurazione completa con `docker-compose` per un avvio rapido.
- **Script di Download**: Script pronti all'uso per scaricare modelli ottimizzati da HuggingFace.

## 🛠️ Prerequisiti

- [Docker](https://www.docker.com/) e Docker Compose installati.
- Almeno 4GB di RAM libera per l'esecuzione del modello 3B.

## 📥 Installazione e Setup

### 1. Clona il repository
```bash
git clone <tuo-repo-url>
cd llama-minion
```

### 2. Scarica un modello
Scegli quale modello vuoi utilizzare. Di default il progetto è configurato per **Qwen2.5-3B**.

Per Qwen:
```bash
chmod +x download-qwen.sh
./download-qwen.sh
```

Per Phi-4:
```bash
chmod +x download-phi.sh
./download-phi.sh
```

### 3. Avvio con Docker Compose
```bash
docker-compose up --build
```

## ⚙️ Configurazione

Puoi personalizzare il comportamento nel file `docker-compose.yml` agendo sulle variabili d'ambiente:

| Variabile | Descrizione | Default |
|-----------|-------------|---------|
| `THREADS` | Numero di core CPU assegnati | `2` |
| `CTX_SIZE`| Dimensione della finestra di contesto | `32000` |
| `MODEL_FILE`| Nome del file del modello in `/models` | `Qwen2.5-3B-Instruct-Q4_K_M.gguf` |

## 🏗️ Architettura

Il sistema si compone di due servizi principali:

1. **llama-minion**: Il cuore del progetto. Espone le API compatibili con OpenAI sulla porta `8080`. Utilizza l'immagine ufficiale `llama.cpp` server.
2. **mcp-weather**: Un server di esempio basato su `@modelcontextprotocol/server-everything`. Espone tool e risorse via SSE (Server-Sent Events) sulla porta `3003`.

## 📡 Utilizzo API

Una volta avviato, puoi interagire con il server sulla porta `8080`.
Esempio di test rapido:

```bash
curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {"role": "system", "content": "Sei un assistente utile."},
      {"role": "user", "content": "Ciao, chi sei?"}
    ]
  }'
```

## 📝 Note sulla Licenza
Assicurati di rispettare le licenze dei modelli scaricati (Qwen, Phi) e dei tool utilizzati.
