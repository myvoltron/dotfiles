#!/bin/bash
set -e

JSON_FILE=".chezmoidata/packages.json"

# 1. 실시간 brew 패키지 목록 추출
brew_output=$(brew bundle dump --file=-)
brew_list=($(echo "$brew_output" | grep '^brew ' | awk '{print $2}' | tr -d '"'))
cask_list=($(echo "$brew_output" | grep '^cask ' | awk '{print $2}' | tr -d '"'))

# 2. 기존 JSON 로드
if [[ -f "$JSON_FILE" ]]; then
  all_json=$(cat "$JSON_FILE")
else
  all_json='{}'
fi

# 3. 기존 항목 추출
existing_brews=$(echo "$all_json" | jq -r '.packages.darwin.brews // [] | .[]')
existing_casks=$(echo "$all_json" | jq -r '.packages.darwin.casks // [] | .[]')

# 4. 병합 + 중복 제거
merged_brews=$(printf "%s\n%s\n" "${existing_brews}" "${brew_list[@]}" | sort -u)
merged_casks=$(printf "%s\n%s\n" "${existing_casks}" "${cask_list[@]}" | sort -u)

# 5. JSON 구조 갱신
updated_json=$(echo "$all_json" | jq \
  --argjson brews "$(printf '%s\n' $merged_brews | jq -R . | jq -s .)" \
  --argjson casks "$(printf '%s\n' $merged_casks | jq -R . | jq -s .)" \
  '.packages.darwin.brews = $brews | .packages.darwin.casks = $casks')

# 6. 저장
echo "$updated_json" >"$JSON_FILE"

echo "✅ Updated $JSON_FILE (packages.darwin.{brews,casks} merged)"
