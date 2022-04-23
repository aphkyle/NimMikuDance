import std/[streams, encodings]

proc readText*(s: Stream, encoding: bool): string =
  let textSize = s.readInt32()
  let text = s.readStr(textSize)
  return if encoding: text else: text.convert("utf-8", "utf-16")