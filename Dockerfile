# Stage 1: Build the Frontend
FROM node:18-alpine as frontend-build
WORKDIR /app
COPY Frontend/package*.json ./
RUN npm install
COPY Frontend/ .
RUN npm run build

# Stage 2: Build the Backend and serve everything
FROM python:3.11-slim
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy Backend requirements and install
COPY Backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Backend code
COPY Backend/ .

# Copy built Frontend assets from Stage 1 to static directory
COPY --from=frontend-build /app/dist /app/static

# Expose port (Digital Ocean looks for 8080 by default in some docs, but we'll use 8000)
EXPOSE 8000

# Start command
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
