import std/[streams]
import pmxTypes, pmxText
import ../read

proc initFrame*(s: Stream, boneIndex, morphIndex: int8): Frame =
  s.read(result.frameType)
  if result.frameType:
    var temp = MorphFrameSlot()
    temp.morphIndex = s.readIndex(morphIndex)
    result.frameSlot = temp
    
  else:
    var temp = BoneFrameSlot()
    temp.boneIndex = s.readIndex(boneIndex)
    result.frameSlot = temp

proc initDisplayFrame*(s:Stream, encoding: bool, boneIndex, morphIndex: int8): DisplayFrame =
  result.displayFrameName.local = s.readText(encoding)
  result.displayFrameName.universal = s.readText(encoding)
  result.specialFlag = s.readBool()
  s.read(result.frameCount)
  for _ in 1..result.frameCount:
    result.frames.add(
      s.initFrame(
        boneIndex,
        morphIndex
      )
    )
  