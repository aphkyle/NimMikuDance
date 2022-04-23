import std/[streams]
import pmxText, pmxTypes
import ../read

proc initRigidBody*(s: Stream, boneIndex: int8, encoding: bool): RigidBody =
  result.rigidBodyName.local = s.readText(encoding)
  result.rigidBodyName.universal = s.readText(encoding)
  result.relatedBoneIndex = s.readIndex(boneIndex)
  s.read(result.groupId)
  s.read(result.nonCollisionGroup)
  s.read(result.shape)
  s.read(result.shapeSize)
  s.read(result.shapePosition)
  s.read(result.shapeRotation)
  s.read(result.mass)
  s.read(result.moveAttenuation)
  s.read(result.rotationDamping)
  s.read(result.repulsion)
  s.read(result.frictionForce)
  s.read(result.physicsMode)