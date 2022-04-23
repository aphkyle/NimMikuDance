import std/[streams, strutils, unicode]
import pmxTypes, pmxText
import ../read

proc initIkLinks*(s: Stream, boneIndexSize: int8): IkLinks =
  result.boneIndex = s.readIndex(boneIndexSize)
  s.read(result.hasLimits)
  if result.hasLimits == 1:
    s.read(result.ikAngleLimits)

proc initIk*(s: Stream, boneIndexSize: int8): BoneIk =
  result.targetIndex = s.readIndex(boneIndexSize)
  s.read(result.loopCount)
  s.read(result.limitRadian)
  s.read(result.linkCount)
  for _ in 1..result.linkCount:
    result.ikLinks.add(
      s.initIkLinks(boneIndexSize)
    )

proc initBone*(s: Stream, boneIndexSize: int8, encoding: bool): Bone =
  result.boneName.local = s.readText(encoding)
  result.boneName.universal = s.readText(encoding)
  s.read(result.position)
  result.parentBoneIndex = s.readIndex(boneIndexSize)
  s.read(result.layer)
  s.read(result.flag)
  let flags = result.flag.toBin(16).reversed
  # `reversed` is needed because it follows little endian (?)
  if flags[0] == '0':
    let temp = TPVec3()
    s.read(temp.value)
    result.tailPosition = temp
  else:
    let temp = TPInt()
    temp.value = s.readIndex(boneIndexSize)
    result.tailPosition = temp
  if flags[8] == '1' or flags[9] == '1':
    result.inheritBone.parentIndex = s.readIndex(boneIndexSize)
    s.read(result.inheritBone.parentInfluence)
  if flags[10] == '1':
    s.read(result.fixedAxis)
  if flags[11] == '1':
    s.read(result.localCoOrdinate)
  if flags[13] == '1':
    result.externalParent = s.readIndex(boneIndexSize)
  if flags[5] == '1':
    result.ik = s.initIk(boneIndexSize)
  
  