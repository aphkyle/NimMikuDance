import std/[streams, strformat]

proc readVertexIndex*(s: Stream, indexSize: int8): int =
  case indexSize:
    of 1:
      return int(s.readUInt8())
    of 2:
      return int(s.readUInt16())
    of 4:
      return int(s.readInt32())
    else:
      raise newException(IOError, fmt"Invalid indexSize {indexSize} (corrupted file?)")

proc readIndex*(s: Stream, indexSize: int8): int =
  case indexSize:
    of 1:
      result = int(s.readInt8())
    of 2:
      result = int(s.readInt16())
    of 4:
      result = int(s.readInt32())
    else:
      raise newException(IOError, fmt"Invalid indexSize {indexSize} (corrupted file?)")