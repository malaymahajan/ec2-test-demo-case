#!/bin/bash

# Set variables
VENV_DIR="robot-env"
TEST_FILE="demo.robot"

# Activate virtual environment
echo "🔁 Activating virtual environment..."
source ${VENV_DIR}/bin/activate

# Run Robot Framework test
echo "🚀 Running Robot Framework test: ${TEST_FILE}"
robot ${TEST_FILE}

# Deactivate environment
deactivate
echo "✅ Done."
