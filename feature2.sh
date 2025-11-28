#!/bin/bash

# 1. 최근 커밋 메시지 가져오기
LAST_COMMIT_HASH=$(git log -1 --format=%h)
LAST_COMMIT_MSG=$(git log -1 --pretty=format:"%s")

echo "--- 📋 최근 커밋 요약 ---"
echo "커밋 ID: ${LAST_COMMIT_HASH}"
echo "커밋 메시지: ${LAST_COMMIT_MSG}"
echo "--------------------------"
echo ""

# 2. 변경된 파일 목록 가져오기 (배열에 저장)
CHANGED_FILES=($(git diff-tree --no-commit-id --name-only -r HEAD))

if [ ${#CHANGED_FILES[@]} -eq 0 ]; then
    echo "🚨 이 커밋에서는 변경된 파일이 없습니다."
    exit 0
fi

echo "--- 📁 변경 파일 목록 (${#CHANGED_FILES[@]}개) ---"
for FILE in "${CHANGED_FILES[@]}"; do
    echo " • ${FILE}"
done
echo "-----------------------------------"
echo ""

# 3. 사용자에게 파일별 상세 정보 출력 여부 묻기
read -p "각 파일의 상세 변경 내용(diff)을 확인하시겠습니까? (y/n): " ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    echo ""
    echo "--- 🔎 파일별 상세 변경 내용 ---"
    
    # 각 파일을 순회하며 상세 diff 출력
    for FILE in "${CHANGED_FILES[@]}"; do
        echo "## 파일: ${FILE}"
        
        # 파일별 변경 내역을 HEAD 커밋과 HEAD^ (이전 커밋) 사이에서 비교
        git diff HEAD^ HEAD -- "$FILE"
        echo "-----------------------------------"
        echo ""
    done
else
    echo "상세 내용 출력을 건너뜝니다."
fi

echo "✨ 작업 완료."