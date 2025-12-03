#!/bin/sh
#실행하기전 
#cp feature3.sh .git/hooks/prepare-commit-msg
#chmod +x .git/hooks/prepare-commit-msg
#export BUILD_VERSION="test1"
COMMIT_MSG_FILE=$1 #첫 번째 인자

if [ -n "$BUILD_VERSION" ]; then #환경변수 비어있는지 확인
    echo "" >> "$COMMIT_MSG_FILE"
    echo "---" >> "$COMMIT_MSG_FILE"
    echo "Environment Info:" >> "$COMMIT_MSG_FILE"
    echo "BUILD_VERSION: $BUILD_VERSION" >> "$COMMIT_MSG_FILE"
fi