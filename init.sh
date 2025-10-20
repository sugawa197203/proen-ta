if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi

DIR_NAME="$1"
mkdir -p "$DIR_NAME"

cp -r template/* "$DIR_NAME"
cd "$DIR_NAME"
touch solve.c target.c
mkdir input
