#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting Flutter web build..."

# Install Flutter if not already installed
if ! command -v flutter &> /dev/null; then
    echo "📦 Installing Flutter..."
    
    # Download Flutter
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
    export PATH="$PATH:`pwd`/flutter/bin"
    
    # Pre-download Dart binaries
    flutter precache
fi

# Get Flutter dependencies
echo "📚 Getting Flutter dependencies..."
flutter pub get

# Build Flutter web app
echo "🔨 Building Flutter web app..."
flutter build web --release

# Copy static files to build directory
echo "📄 Copying static files to build directory..."
if [ -d "public" ]; then
    cp -r public/* build/web/
fi

echo "✅ Build completed successfully!" 