#!/bin/bash

# Update system packages
sudo apt-get update -y

# Install OpenJDK 17 (standard for modern Java apps)
sudo apt-get install -y openjdk-17-jre

# Verify Java installation
java -version

# Run the application
# Assumes the JAR file is transferred to the same directory
echo "Starting Bug Tracking App..."
java -jar BugTracker-1.0-SNAPSHOT.jar
