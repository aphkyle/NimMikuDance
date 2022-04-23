import std/[streams]
import pmxTypes, pmxText
import ../read

proc initMorphGroup*(s: Stream, morphIndexSize: int8): MorphGroup =
  result = MorphGroup()
  result.morphIndex = s.readIndex(morphIndexSize)
  s.read(result.influence)

proc initMorphVertex*(s: Stream, vertexIndexSize: int8): MorphVertex =
  result = MorphVertex()
  result.vertexIndex = s.readIndex(vertexIndexSize)
  s.read(result.translation)

proc initMorphBone*(s: Stream, boneIndexSize: int8): MorphBone =
  result = MorphBone()
  result.boneIndex = s.readIndex(boneIndexSize)
  s.read(result.translation)
  s.read(result.rotation)

proc initMorphUv*(s: Stream, vertexIndexSize: int8, ext: 0..4): MorphUv =
  result = MorphUv()
  result.ext = ext
  result.vertexIndex = s.readIndex(vertexIndexSize)
  s.read(result.floats)

proc initMorphMaterial*(s: Stream, materialIndexSize: int8): MorphMaterial =
  result = MorphMaterial()
  result.materialIndex = s.readIndex(materialIndexSize)
  s.read(result.calcMode)
  s.read(result.diffuse)
  s.read(result.specular)
  s.read(result.specularity)
  s.read(result.ambient)
  s.read(result.edgeColor)
  s.read(result.edgeSize)
  s.read(result.textureTint)
  s.read(result.environmentTint)
  s.read(result.toonTint)

proc initMorphFlip*(s: Stream, morphIndexSize: int8): MorphFlip =
  result = MorphFlip()
  result.morphIndex = s.readIndex(morphIndexSize)
  s.read(result.influence)

proc initMorphImpulse*(s: Stream, rigidBodySize: int8): MorphImpulse =
  result = MorphImpulse()
  result.rigidBodyIndex = s.readIndex(rigidBodySize)
  s.read(result.localFlag)
  s.read(result.movementSpeed)
  s.read(result.rotationTorque)

proc initMorph*(s:Stream, globals: Globals): Morph =
  result.morphName.local = s.readText(globals.textEncoding)
  result.morphName.universal = s.readText(globals.textEncoding)
  s.read(result.panelType)
  s.read(result.morphType)
  s.read(result.offsetSize)
  case result.morphType
  of 0:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphGroup(globals.morphIndexSize)
      )
  of 1:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphVertex(globals.vertexIndexSize)
      )
  of 2:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphBone(globals.boneIndexSize)
      )
  of 3:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphUv(
            globals.vertexIndexSize,
            0
          )
      )
  of 4:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphUv(
            globals.vertexIndexSize,
            1
          )
      )
  of 5:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphUv(
            globals.vertexIndexSize,
            2
          )
      )
  of 6:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphUv(
            globals.vertexIndexSize,
            3
          )
      )
  of 7:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphUv(
            globals.vertexIndexSize,
            4
          )
      )
  of 8:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphMaterial(globals.materialIndexSize)
      )
  of 9:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphFlip(globals.morphIndexSize)
      )
  of 10:
    for _ in 1..result.offsetSize:
      result.offsetData.add(
        s.initMorphImpulse(globals.rigidBodyIndexSize)
      )
  else:
    raise newException(IoError, "Invalid morph type (malformed file?)")
