# FastAPI Welcome & Health Check App

A simple FastAPI application that serves a welcome page and health endpoint.

## Features

- 🏠 **Welcome Page** - A styled HTML welcome page at the root endpoint (`/`)
- ❤️ **Health Check Endpoint** - JSON health status endpoint at `/health`
- 📚 **Auto Documentation** - Interactive API docs available at `/docs`

## Requirements

- Python 3.8+
- FastAPI
- Uvicorn

## Installation

1. Install dependencies:
```bash
pip install -r requirements.txt
```

## Running the Application

Start the server:
```bash
python main.py
```

Or use uvicorn directly:
```bash
uvicorn main:app --reload
```

The application will be available at `http://localhost:8000`

## Endpoints

- **GET `/`** - Welcome page (HTML)
- **GET `/health`** - Health check status (JSON)
- **GET `/docs`** - Interactive API documentation (Swagger UI)
- **GET `/redoc`** - Alternative API documentation (ReDoc)

## API Response Examples

### Health Endpoint
```json
{
  "status": "healthy",
  "message": "API is running smoothly"
}
```

## Development

The application runs on:
- Host: `0.0.0.0`
- Port: `8000`
- Auto-reload: Enabled when running with `uvicorn main:app --reload`
