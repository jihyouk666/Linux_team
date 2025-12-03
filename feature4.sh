#!/bin/bash

echo "추가할 접두사를 입력하세요 (예: NEW_):"
read PREFIX

if [ -z "$PREFIX" ]; then #문자열 길이가 0이면
    echo "오류: 접두사를 입력해야 합니다."
    exit 1
fi

echo "다음 접두사가 추가됩니다: $PREFIX"

COUNT=0

IFS=$'\n' # 기본값은 공백, 탭, 줄바꿈->줄바꿈만 설정, (공백 포함 파일명 가능)
for ITEM in *; do #모든 항목 순회
    

    if [ -f "$ITEM" ]; then #일반 파일인지 검사
        
        NEW_NAME="${PREFIX}${ITEM}"
        
        mv "$ITEM" "$NEW_NAME" #파일 이름 변경
        
        echo "변경 완료: $ITEM -> $NEW_NAME"
        COUNT=$((COUNT + 1)) #이름변경 파일 수 증가
        
    fi
done

echo "총 $COUNT 개의 파일 이름이 변경되었습니다."