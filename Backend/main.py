from fastapi import FastAPI

from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/hello")
def hello():
    return {"message": "Hello from FastAPI"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

# Mount the static directory (Frontend build)
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import os

# Create static directory if it doesn't exist (for local testing without build)
if not os.path.exists("static"):
    os.makedirs("static")

app.mount("/static", StaticFiles(directory="static"), name="static")

# Catch-all route for SPA (Vue Router)
@app.get("/{full_path:path}")
async def catch_all(full_path: str):
    # If path is empty (root), serve index.html
    if full_path == "" or full_path == "/":
        if os.path.exists("static/index.html"):
            return FileResponse("static/index.html")
        return {"error": "Frontend not found (static/index.html missing)"}

    # Check if the file exists in static folder (e.g. css/app.css, favicon.ico)
    # We strip relative path components to be safe
    safe_path = os.path.normpath(os.path.join("static", full_path))
    # Ensure it's inside static folder
    if not safe_path.startswith("static"):
        return FileResponse("static/index.html")

    if os.path.exists(safe_path) and os.path.isfile(safe_path):
        return FileResponse(safe_path)
    
    # Otherwise return index.html (SPA Fallback)
    if os.path.exists("static/index.html"):
        return FileResponse("static/index.html")
    return {"error": "Frontend not found"}
