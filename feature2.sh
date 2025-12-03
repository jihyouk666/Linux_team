#!/bin/bash

LAST_COMMIT_HASH=$(git log -1 --format=%h) #최근 1개 커밋,커밋 해시값
LAST_COMMIT_MSG=$(git log -1 --pretty=format:"%s") #제목 줄만

echo "최근 커밋 요약"
echo "커밋 ID: ${LAST_COMMIT_HASH}"
echo "커밋 메시지: ${LAST_COMMIT_MSG}"

CHANGED_FILES=($(git diff-tree --no-commit-id --name-only -r HEAD)) #커밋 해시값 말고 이름만 받기

if [ ${#CHANGED_FILES[@]} -eq 0 ]; then # 배열의 요소 개수 0 인지 확인
    echo "이 커밋에서는 변경된 파일이 없습니다"
    exit 0
fi

echo "변경 파일 목록 (${#CHANGED_FILES[@]}개)"
for FILE in "${CHANGED_FILES[@]}"; do #변경 파일의 개수만큼 반영
    echo "${FILE}"
done

read -p "각 파일의 상세 변경 내용(diff)을 확인하시겠습니까? (y/n): " ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    echo "파일별 상세 변경 내용"
    
    for FILE in "${CHANGED_FILES[@]}"; do
        echo "## 파일: ${FILE}"
        
        # 파일별 변경 내역을 HEAD 커밋과 HEAD^ (이전 커밋) 사이에서 비교
        git diff HEAD^ HEAD -- "$FILE"
    done
else
    echo "상세 내용 출력을 건너뜁니다"
fi

echo "작업 완료"