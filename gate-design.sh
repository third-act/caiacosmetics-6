#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo "==> gate-design.sh — caiacosmetics-6"

if ! command -v flutter >/dev/null 2>&1; then
  export PATH="$HOME/flutter/bin:$PATH"
fi

flutter pub get
flutter analyze

flutter build web --release --base-href /caiacosmetics-6/

required=(
  lib/ui/shared_widgets/tab_pill.dart
  lib/ui/shared_widgets/pressable_card.dart
  lib/ui/shared_widgets/app_space.dart
  lib/ui/shared_widgets/app_shadows.dart
  lib/ui/shared_widgets/brand_field.dart
  lib/ui/views/hudscan_view.dart
  lib/ui/views/recommendations_view.dart
  lib/ui/views/profile_view.dart
  .github/workflows/pages.yml
)

for file in "${required[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "FAIL missing $file"
    exit 1
  fi
done

if rg -q "Image\.network" lib/; then
  echo "FAIL Image.network found — use bundled assets"
  exit 1
fi

if rg -q "info@caiacosmetics\.com|pal@thirdact\.se" lib/; then
  echo "FAIL forbidden email in UI"
  exit 1
fi

echo "PASS gate-design.sh"
