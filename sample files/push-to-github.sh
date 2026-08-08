#!/bin/bash
# ============================================================
# SRE-Roadmap Mentor Setup — Push Script
# ============================================================
# This script helps you push the mentor setup to your GitHub repo.
# 
# HOW TO USE:
# 1. Download SRE-Roadmap-mentor-setup.tar.gz (from the workspace)
# 2. Put this script and the tar.gz in the same folder
# 3. Open a terminal (Git Bash on Windows, Terminal on Mac/Linux)
# 4. Run: bash push-to-github.sh
# 5. Follow the prompts
# ============================================================

set -e

REPO_URL="https://github.com/PunithKumarSRE1305/SRE-Roadmap.git"
BRANCH="mentor/sre-journey-setup"

echo "============================================"
echo "  SRE-Roadmap Mentor Setup — Push Script"
echo "============================================"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed!"
    echo "   Install it from: https://git-scm.com/downloads"
    echo "   Then run this script again."
    exit 1
fi
echo "✅ Git is installed: $(git --version)"

# Check if the tarball exists
if [ ! -f "SRE-Roadmap-mentor-setup.tar.gz" ]; then
    echo "❌ SRE-Roadmap-mentor-setup.tar.gz not found!"
    echo "   Download it from the workspace and put it in this folder."
    exit 1
fi
echo "✅ Tarball found"

# Configure git if not already done
if [ -z "$(git config user.name)" ]; then
    echo ""
    echo "⚠️  Git is not configured. Let's set it up."
    read -p "Enter your name: " GIT_NAME
    read -p "Enter your email: " GIT_EMAIL
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    echo "✅ Git configured"
fi

echo ""
echo "Cloning your repository..."
git clone "$REPO_URL" SRE-Roadmap-temp
cd SRE-Roadmap-temp

echo "Creating branch: $BRANCH"
git checkout -b "$BRANCH"

echo "Extracting mentor setup files..."
tar xzf ../SRE-Roadmap-mentor-setup.tar.gz --strip-components=1

echo "Staging all changes..."
git add -A

echo "Committing..."
git commit -m "feat: complete SRE mentor setup — 15 concepts, day-wise timetable, visual tracker, strict gating process"

echo ""
echo "Pushing to GitHub..."
echo "(You may be asked for your GitHub username and password/token)"
git push -u origin "$BRANCH"

echo ""
echo "============================================"
echo "  ✅ SUCCESS! Branch pushed to GitHub!"
echo "============================================"
echo ""
echo "Next steps:"
echo "1. Go to: https://github.com/PunithKumarSRE1305/SRE-Roadmap"
echo "2. You'll see a yellow banner about the new branch"
echo "3. Click 'Compare & pull request'"
echo "4. Title: 'Merge mentor SRE setup'"
echo "5. Click 'Create pull request'"
echo "6. Click 'Merge pull request' to merge into main"
echo ""
echo "Done! Your SRE roadmap is ready. 🚀"
