#!/bin/bash

# Variables
PACKAGE_ROOT="com.lunar-magic.magic-console"

# This script adds the package NaughtyAttributes as an embebbed dependency for the project.
# At: PROJECT_ROOT/
printf ">>> Cleaning embebbed dependencies directory...\n"
rm -rf Packages/$PACKAGE_ROOT/Dependencies/ Packages/$PACKAGE_ROOT/Dependencies.meta
mkdir --parents Packages/$PACKAGE_ROOT/Dependencies/NaughtyAttributes/

printf ">>> Cloning NaughtyAttributes from GitHub to temporary directory...\n"
git clone https://github.com/dbrizov/NaughtyAttributes.git Temp/Dependencies/NaughtyAttributes/

# At: PROJECT_ROOT/Temp/Dependencies/NaughtyAttributes/
printf ">>> Checking out latests up-to-date branch (currently v2)...\n"
cd Temp/Dependencies/NaughtyAttributes/
git checkout v2

printf ">>> Copying package LICENSE and README...\n"
find . -type f \
    \(  -iname "LICENSE" \
        -o -iname "README.md" \
    \) -exec cp --parents {} ../../../Packages/$PACKAGE_ROOT/Dependencies/NaughtyAttributes/ \;

# At: PROJECT_ROOT/Temp/Dependencies/NaughtyAttributes/Assets/NaughtyAttributes/
printf ">>> Copying only required files to compile the package...\n"
cd Assets/NaughtyAttributes/
find . -type f \
    \(  -iwholename "*/Scripts/Core/*.cs" \
        -o -iwholename "*/Scripts/Editor/*.cs" \
        -o -iwholename "*/Scripts/Core/*.asmdef" \
        -o -iwholename "*/Scripts/Editor/*.asmdef" \
    \) -exec cp --parents {} ../../../../../Packages/$PACKAGE_ROOT/Dependencies/NaughtyAttributes/ \;

# At PROJECT_ROOT/
printf ">>> Cleaning temporary directory...\n"
cd ../../../../../
rm -rf Temp/Dependencies/