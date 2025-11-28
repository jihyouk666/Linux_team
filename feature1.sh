#!/bin/bash

# 1. 사용자로부터 확장자 입력받기 (점(.) 없이 입력)
echo "정리할 파일의 확장자를 입력하세요 (예: txt, jpg):"
read TARGET_EXT

# 확장자 입력 검사
if [ -z "$TARGET_EXT" ]; then
    echo "오류: 확장자를 입력해야 합니다."
    exit 1
fi

# 2. 정리 폴더 설정 및 생성
DEST_DIR="${TARGET_EXT}_FILES_MOVED"

if [ ! -d "$DEST_DIR" ]; then
    mkdir "$DEST_DIR"
    echo "--> 정리 폴더 '$DEST_DIR' 생성 완료."
fi

# 3. 반복문과 조건문을 사용하여 파일 정리
COUNT=0
# 현재 폴더의 모든 항목을 순회 (공백 포함 파일명 처리를 위해 IFS 설정)
IFS=$'\n'
for ITEM in *; do
    
    # 3-1. 조건문 1: 현재 항목이 '파일'인지 확인 (폴더는 건너뛰기)
    if [ -f "$ITEM" ]; then
        
        # 3-2. 조건문 2: 파일 이름에 ".확장자" 문자열이 포함되어 있는지 grep으로 확인
        # grep -q: 결과를 출력하지 않고 (q: quiet), 매칭되면 성공(exit 0), 아니면 실패(exit 1)를 반환
        # grep의 반환 값(exit code)을 if 조건문에서 바로 사용
        
        # 
        
        if echo "$ITEM" | grep -q "\.$TARGET_EXT$"; then 
            # 정규표현식 \.$TARGET_EXT$: .확장자 문자가 파일 이름 끝에 있는지 확인
            
            # 3-3. 파일 이동 및 카운트 증가
            mv "$ITEM" "$DEST_DIR/"
            echo "    [이동 완료]: $ITEM"
            COUNT=$((COUNT + 1))
            
        fi
    fi
done

# 4. 최종 결과 출력
echo "-----------------------------------------"
echo "총 $COUNT 개의 파일이 '$DEST_DIR' 폴더로 정리되었습니다."