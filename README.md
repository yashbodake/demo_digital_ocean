# Full Stack Application: Vue.js + FastAPI

This is a full stack application with Vue.js frontend and FastAPI backend.

## Project Structure

```
DemoToDigitalOcean/
├── Backend/
│   ├── main.py          # FastAPI application
│   ├── requirements.txt # Python dependencies
│   └── Dockerfile       # Backend Docker configuration
└── Frontend/
    ├── src/             # Vue.js source files
    ├── public/          # Public assets
    ├── package.json     # Node.js dependencies
    ├── vue.config.js    # Vue.js configuration
    ├── Dockerfile       # Frontend Docker configuration
    └── nginx.conf       # Nginx configuration
```

## Running the Application

### Development Mode

1. **Backend**: Navigate to `/Backend` and run:
   ```bash
   pip install -r requirements.txt
   uvicorn main:app --reload
   ```

2. **Frontend**: Navigate to `/Frontend` and run:
   ```bash
   npm install
   npm run serve
   ```

### Production Mode with Docker

Build and run with Docker Compose:
```bash
docker-compose up --build
```

Access the application at `http://localhost:80`

## API Endpoints

- GET `/api/hello` - Returns a hello message from the backend

## Deployment

This application is designed for deployment on DigitalOcean App Platform.
See `DEPLOYMENT.md` for detailed instructions.