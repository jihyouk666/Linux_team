#!/bin/sh

COMMIT_MSG_FILE=$1  # 커밋 메시지 파일 경로를 인자로 받습니다.

# 환경변수(BUILD_VERSION) 확인 조건문
if [ -n "$BUILD_VERSION" ]; then
    # 파일 끝에 내용 추가
    echo "" >> "$COMMIT_MSG_FILE"
    echo "---" >> "$COMMIT_MSG_FILE"
    echo "Environment Info:" >> "$COMMIT_MSG_FILE"
    echo "BUILD_VERSION: $BUILD_VERSION" >> "$COMMIT_MSG_FILE"
fi