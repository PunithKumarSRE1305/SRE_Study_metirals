#!/usr/bin/env python3
"""
Extract tar.gz files in the repository and commit them.
This script can be run directly in GitHub Codespaces or locally.
"""

import tarfile
import os
import glob
from pathlib import Path

def extract_all_tar_files():
    """Find and extract all tar.gz files in the repository."""
    
    print("🔍 Searching for tar.gz files...")
    tar_files = glob.glob('**/*.tar.gz', recursive=True)
    
    if not tar_files:
        print("❌ No tar.gz files found!")
        return False
    
    extracted = False
    
    for tar_file in tar_files:
        try:
            print(f"\n📦 Found: {tar_file}")
            
            # Get the directory where the tar file is located
            extract_path = os.path.dirname(tar_file)
            if not extract_path:
                extract_path = '.'
            
            print(f"📂 Extracting to: {extract_path}")
            
            # Extract the tar.gz file
            with tarfile.open(tar_file, 'r:gz') as tar:
                tar.extractall(path=extract_path)
            
            print(f"✅ Successfully extracted: {tar_file}")
            extracted = True
            
            # List extracted files
            print(f"📋 Files extracted:")
            for member in tarfile.open(tar_file, 'r:gz').getmembers():
                print(f"   - {member.name}")
                
        except Exception as e:
            print(f"❌ Error extracting {tar_file}: {str(e)}")
    
    return extracted

if __name__ == "__main__":
    print("=" * 50)
    print("TAR.GZ EXTRACTOR")
    print("=" * 50)
    
    if extract_all_tar_files():
        print("\n" + "=" * 50)
        print("✅ Extraction complete!")
        print("=" * 50)
        print("\n📝 Next steps:")
        print("1. Review the extracted files")
        print("2. Commit changes: git add . && git commit -m 'Extract tar files'")
        print("3. Push to GitHub: git push origin main")
    else:
        print("\n❌ No files were extracted")
