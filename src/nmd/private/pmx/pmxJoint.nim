import std/[streams]
import pmxText, pmxTypes
import ../read

proc initJoint*(s: Stream, rigidBodyIndex: int8, encoding: bool): Joint =
  result.jointName.local = s.readText(encoding)
  result.jointName.universal = s.readText(encoding)
  s.read(result.jointType)
  result.rigidBodyIndexA = s.readIndex(rigidBodyIndex)
  result.rigidBodyIndexB = s.readIndex(rigidBodyIndex)
  s.read(result.position)
  s.read(result.rotation)
  s.read(result.positionMinimum)
  s.read(result.positionMaximum)
  s.read(result.rotationMinimum)
  s.read(result.rotationMaximum)
  s.read(result.positionSpring)
  s.read(result.rotationSpring)