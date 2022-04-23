import std/[streams, strformat]
import pmxTypes
import ../read

proc newBdef1*(s: Stream, boneIndexSize: int8): Bdef1 =
  result = Bdef1()
  result.bone1Index = s.readIndex(boneIndexSize)
  result.bone1Weight = 1
proc newBdef2*(s: Stream, boneIndexSize: int8): Bdef2 =
  result = Bdef2()
  result.bone1Index = s.readIndex(boneIndexSize)
  result.bone2Index = s.readIndex(boneIndexSize)
  s.read(result.bone1Weight)
  result.bone2Weight = 1.0 - result.bone1Weight

proc newBdef4*(s: Stream, boneIndexSize: int8): Bdef4 =
  result = Bdef4()
  result.bone1Index = s.readIndex(boneIndexSize)
  result.bone2Index = s.readIndex(boneIndexSize)
  result.bone3Index = s.readIndex(boneIndexSize)
  result.bone4Index = s.readIndex(boneIndexSize)
  s.read(result.bone1Weight)
  s.read(result.bone2Weight)
  s.read(result.bone3Weight)
  s.read(result.bone4Weight)

proc newSdef*(s: Stream, boneIndexSize: int8): Sdef =
  result = Sdef()
  result.bone1Index = s.readIndex(boneIndexSize)
  result.bone2Index = s.readIndex(boneIndexSize)
  s.read(result.bone1Weight)
  result.bone2Weight = 1.0 - result.bone1Weight
  s.read(result.c0)
  s.read(result.r0)
  s.read(result.r1)

proc newQdef*(s: Stream, boneIndexSize: int8): Qdef =
  result = Qdef()
  result.bone1Index = s.readIndex(boneIndexSize)
  result.bone2Index = s.readIndex(boneIndexSize)
  result.bone3Index = s.readIndex(boneIndexSize)
  result.bone4Index = s.readIndex(boneIndexSize)
  s.read(result.bone1Weight)
  s.read(result.bone2Weight)
  s.read(result.bone3Weight)
  s.read(result.bone4Weight)

proc readDeform*(s: Stream, deformType: uint8, boneIndexSize: int8): Deforms =
  case deformType
  of 0: result = newBdef1(s, boneIndexSize)
  of 1: result = newBdef2(s, boneIndexSize)
  of 2: result = newBdef4(s, boneIndexSize)
  of 3: result = newSdef(s, boneIndexSize)
  of 4: result = newQdef(s, boneIndexSize)
  else: raise newException(IOError, fmt"Invalid deformType {deformType} (your file is potentially corrupted)")