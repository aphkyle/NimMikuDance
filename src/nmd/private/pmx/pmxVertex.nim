import std/[streams]
import pmxTypes, pmxDeforms

proc initVertex*(s: Stream, additionalVec4Count: int, boneIndexSize: int8): Vertex =
  s.read(result.position)
  s.read(result.normal)
  s.read(result.uv)
  if unlikely(additionalVec4Count != 0):
    for _ in 1..additionalVec4Count:
      result.additionalVec4.add s.readFloat32()
  s.read(result.weightDeformType)
  result.weightDeform = s.readDeform(result.weightDeformType, boneIndexSize)
  s.read(result.edgeScale)