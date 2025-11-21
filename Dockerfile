# STAGE 1: The Builder (Compiling dependencies)
# We use a larger image to build the requirements
FROM python:3.9-slim as builder

WORKDIR /usr/src/app

# Optimization: Copy only requirements first to leverage Docker Cache
COPY requirements.txt .
# FIX 1: Remove '--user'. This installs packages globally (e.g., in /usr/local/bin), 
# which is accessible to the appuser.
RUN pip install -r requirements.txt

# STAGE 2: The Runner (The final image)
# We switch to a fresh, tiny image to keep it lightweight
FROM python:3.9-slim

WORKDIR /usr/src/app

# FIX 2: Since we installed globally, we copy the necessary global files/libraries.
# This ensures Flask and Redis libraries are present and accessible.
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# Copy the actual application code
COPY . .

# Security: Create a non-root user and switch to it
RUN useradd -m appuser
USER appuser

# Command to run the app
CMD ["flask", "run", "--host=0.0.0.0"]