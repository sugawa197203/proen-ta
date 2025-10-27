#!/bin/bash

# --- 初期設定 ---
# 必要なディレクトリとファイルを定義
INPUT_DIR="input"
OUTPUT_DIR="output"
SOLVE_C="solve.c"
TARGET_C="target.c"
SOLVE_BIN="solve"
TARGET_BIN="target"
COMPILER="gcc"

# ディレクトリが存在するか確認
if [ ! -d "$INPUT_DIR" ]; then
    echo "エラー: '$INPUT_DIR' ディレクトリが見つかりません。"
    exit 1
fi

# 想定解（solve.c）が存在するか確認
if [ ! -f "$SOLVE_C" ]; then
    echo "エラー: '$SOLVE_C' ファイルが見つかりません。"
    exit 1
fi

# 採点対象コード（target.c）が存在するか確認
if [ ! -f "$TARGET_C" ]; then
    echo "エラー: '$TARGET_C' ファイルが見つかりません。"
    exit 1
fi

# --- 想定解の出力生成 ---
echo "--- 想定解の出力ファイルを生成中 ---"

# 既存の出力ディレクトリを削除し、新しく作成
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# 想定解をコンパイル
$COMPILER "$SOLVE_C" -o "$SOLVE_BIN"
if [ $? -ne 0 ]; then
    echo "エラー: '$SOLVE_C' のコンパイルに失敗しました。"
    exit 1
fi

# inputディレクトリ内の各ファイルに対し、想定解を実行して出力を保存
for input_file in "$INPUT_DIR"/*; do
    if [ -f "$input_file" ]; then
        filename=$(basename "$input_file")
        output_file="$OUTPUT_DIR/${filename%.*}.out"
        echo "入力ファイル: $filename -> 出力ファイル: $(basename "$output_file")"
        ./"$SOLVE_BIN" < "$input_file" > "$output_file"
    fi
done

# --- 採点対象コードの検証 ---
echo -e "\n--- 採点対象コードを検証中 ---"
all_passed=true

# 採点対象コードをコンパイル
$COMPILER "$TARGET_C" -o "$TARGET_BIN"
if [ $? -ne 0 ]; then
    echo "エラー: '$TARGET_C' のコンパイルに失敗しました。"
    exit 1
fi

# inputディレクトリ内の各ファイルと対応するoutputディレクトリ内のファイルでdiffを実行
for input_file in "$INPUT_DIR"/*; do
    if [ -f "$input_file" ]; then
        filename=$(basename "$input_file")
        expected_output="$OUTPUT_DIR/${filename%.*}.out"

        # 想定解の出力ファイルが存在するか確認
        if [ ! -f "$expected_output" ]; then
            echo "警告: 想定解の出力ファイル '$expected_output' が見つかりません。スキップします。"
            continue
        fi

        # 採点対象コードを実行し、一時ファイルに保存
        temp_output=$(mktemp)
        ./"$TARGET_BIN" < "$input_file" > "$temp_output"

        # diffで比較
        if diff -q "$expected_output" "$temp_output" > /dev/null; then
            echo "✅ $filename: 合格"
        else
            echo "❌ $filename: 不合格"
            all_passed=false
        fi

        # 一時ファイルを削除
        rm "$temp_output"
    fi
done

# --- 結果の表示 ---
echo -e "\n--- 最終結果 ---"
if $all_passed; then
    echo "🎉 すべてのテストケースに合格しました！"
    exit 0
else
    echo "残念ながら、一部のテストケースに不合格です。"
    exit 1
fi

# コンパイル済みのバイナリを削除
rm -f "$SOLVE_BIN" "$TARGET_BIN"