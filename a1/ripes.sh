set -e
cat <&0 | sed -r 's/%lo\([^)]+\)/0/' | sed -r 's/lui(\s*)(.+), %hi\((.+)\)/la \1\2, \3/' >  tmp.s
n=$((`grep -m 1  '^\s\+\.' -n  tmp.s | cut -d: -f1` - 1))
if ((n <= 2)); then
    echo "can't find breakpoint" >&2
    exit 1
fi
cat  <(echo .data) <(tail -n+$n tmp.s) <(printf "\n.text\n") <(head -$(($n - 2)) tmp.s) <(echo '    j end') lib.s <(echo end:)
rm tmp.s
