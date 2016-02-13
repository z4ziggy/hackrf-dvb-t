#!/bin/sh

FIFO_D="fifos/"

LIVE_FIFO="$FIFO_D/live.ts"
OUT_FIFO="$FIFO_D/out.ts"

mkdir -p "$FIFO_D"
rm -f "$LIVE_FIFO"
rm -r "$OUT_FIFO"

mkfifo "$LIVE_FIFO"
mkfifo "$OUT_FIFO"

(
  ./src.sh "$LIVE_FIFO" 13270588
) &

(
  tsstamp "$LIVE_FIFO" 13270588 > "$OUT_FIFO"
) &

./dvbt-hackrf.py "$OUT_FIFO"

exit 0
