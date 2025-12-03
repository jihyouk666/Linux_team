#!/bin/bash

echo "정리할 파일의 확장자를 입력하세요 (예: txt, jpg):"
read EXT #사용자 입력

if [ -z "$EXT" ]; then #문자열의 길이가 0이면 참
    echo "확장자를 입력해야 합니다."
    exit 1
fi

DIR="${EXT}_FILES_MOVED"

if [ ! -d "$DIR" ]; then #특정 디렉토리가 존재하지 않을 때
    mkdir "$DIR" #디렉토리 생성
    echo "폴더 '$DIR' 생성"
fi

COUNT=0 #이동한 파일 수를 셀 변수 초기화

IFS=$'\n' # 기본값은 공백, 탭, 줄바꿈->줄바꿈만 설정, (공백 포함 파일명 가능)
for ITEM in *; do

    if [ -f "$ITEM" ]; then # 일반 파일인지 확인
        
        if echo "$ITEM" | grep -q "\.$EXT$"; then 
            #.확장자가 파일 이름 끝에 있는지 확인
            
            mv "$ITEM" "$DIR/" #파일을 폴더로 이동
            echo "이동 완료: $ITEM"
            COUNT=$((COUNT + 1)) #이동 파일 수 증가
            
        fi
    fi
done

echo "총 $COUNT 개의 파일이 '$DIR' 폴더로 이동되었습니다."