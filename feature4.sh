#!/bin/bash

# 1. 사용자로부터 접두사 입력받기
echo "추가할 접두사를 입력하세요 (예: NEW_):"
read INPUT_PREFIX

# 2. 입력 검사: 접두사 입력이 비어있는 경우 종료
if [ -z "$INPUT_PREFIX" ]; then
    echo "오류: 접두사를 입력해야 합니다."
    exit 1
fi

echo "----------------------------------------"
echo "다음 접두사가 추가됩니다: $INPUT_PREFIX"

COUNT=0
# 3. 반복문 시작: 현재 디렉토리의 모든 항목을 순회
# 공백이 포함된 파일명도 안전하게 처리하기 위해 IFS를 사용합니다.
IFS=$'\n'
for ITEM in *; do
    
    # 3-1. 조건문: 현재 항목이 일반 '파일'인지 확인 (폴더는 건너뛰기)
    if [ -f "$ITEM" ]; then
        
        # 3-2. 새 파일 이름 생성: [접두사] + [원래 파일 이름]
        NEW_NAME="${INPUT_PREFIX}${ITEM}"
        
        # 3-3. 파일 이름 변경 (mv 명령어 사용)
        mv "$ITEM" "$NEW_NAME"
        
        echo "    [변경 완료]: $ITEM -> $NEW_NAME"
        COUNT=$((COUNT + 1))
        
    fi
done

# 4. 최종 결과 출력
echo "----------------------------------------"
echo "총 $COUNT 개의 파일 이름이 변경되었습니다."