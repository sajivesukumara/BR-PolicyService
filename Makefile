# Variables
APP_NAME := br-policy-service
BUILD_DIR := build
SRC := ./...

# Default target
.PHONY: all
all: build

# Build the application
.PHONY: build
build:
	@echo "Building the application..."
	mkdir -p $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(APP_NAME) main.go
	@echo "Build complete. Binary is located at $(BUILD_DIR)/$(APP_NAME)"

# Run the application
.PHONY: run
run:
	@echo "Running the application..."
	go run main.go

# Test the application
.PHONY: test
test:
	@echo "Running tests..."
	go test $(SRC) -v

# Clean the build directory
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -rf $(BUILD_DIR)
	@echo "Clean complete."

# Fetch dependencies
.PHONY: deps
deps:
	@echo "Fetching dependencies..."
	go mod tidy
	go mod vendor
	@echo "Dependencies fetched."

# Lint the code
.PHONY: lint
lint:
	@echo "Running linter..."
	go vet $(SRC)
	@echo "Linting complete."

# Format the code
.PHONY: fmt
fmt:
	@echo "Formatting code..."
	go fmt $(SRC)

# Help command to list all targets
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all      - Build the application (default target)"
	@echo "  build    - Build the application"
	@echo "  run      - Run the application"
	@echo "  test     - Run tests"
	@echo "  clean    - Clean the build directory"
	@echo "  deps     - Fetch dependencies"
	@echo "  lint     - Run linter"
	@echo "  fmt      - Format the code"
	@echo "  help     - Show this help message"
