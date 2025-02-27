#!/bin/bash

cd ..


# Step 2: Clean and prepare Android project
echo "Preparing Android project..."
cd android
./gradlew clean      
bundle install       
bundle exec fastlane install_plugins  
cd ..
