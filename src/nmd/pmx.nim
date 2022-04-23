import std/[streams, os]
import
  private/pmx/[
    pmxBones,
    pmxDisplayFrame,
    pmxJoint,
    pmxMaterials,
    pmxMorph,
    pmxRigidBody,
    pmxText,
    pmxTypes,
    pmxVertex
  ]
import private/[read]

proc initPMXFile*(filePath: string): PMXFile =
  doAssert likely(fileExists(filePath)), ".pmx file \"{filePath}\" does not exist"
  let stream = openFileStream(filePath)
  defer: close(stream)
# <header>
  result.header.signature = stream.readStr(4)
  result.header.version = stream.readFloat32()
# <globals>
  stream.read(result.header.globals)
# </globals>
# <model name>
  result.header.modelName.local = stream.readText(result.header.globals.textEncoding)
  result.header.modelName.universal = stream.readText(result.header.globals.textEncoding)
# </model name>
# <comments>
  result.header.comments.local = stream.readText(result.header.globals.textEncoding)
  result.header.comments.universal = stream.readText(result.header.globals.textEncoding)
# </comments>
# </header>
# <vertices>
  stream.read(result.verticesCount)
  for _ in 1..result.verticesCount:
    result.vertices.add(
      stream.initVertex(
        result.header.globals.additionalVec4Count,
        result.header.globals.boneIndexSize
      )
    )
# </vertices>
# <surfaces>
  stream.read(result.surfacesCount)
  result.surfacesCount = result.surfacesCount div 3
  for _ in 1..result.surfacesCount:
    result.surfaces.add(
      [
        stream.readVertexIndex(
          result.header.globals.vertexIndexSize
        ),
        stream.readVertexIndex(
          result.header.globals.vertexIndexSize
        ),
        stream.readVertexIndex(
          result.header.globals.vertexIndexSize
        ),
      ]
    )
# </surfaces>
# <textures>
  stream.read(result.texturesCount)
  for _ in 1..result.texturesCount:
    result.textures.add(
      stream.readText(result.header.globals.textEncoding)
    )
# </textures>
# <materials>
  stream.read(result.materialsCount)
  for _ in 1..result.materialsCount: 
    result.materials.add(
      stream.initMaterial(
        result.header.globals.textureIndexSize,
        result.header.globals.textEncoding
      )
    )
# </materials>
# <bones>
  stream.read(result.bonesCount)
  for _ in 1..result.bonesCount:
    result.bones.add(
      stream.initBone(
          result.header.globals.boneIndexSize,
          result.header.globals.textEncoding
      )
    )
# </bones>
# <morphs>
  stream.read(result.morphsCount)
  for _ in 1..result.morphsCount:
    result.morphs.add(
      stream.initMorph(
        result.header.globals
      )
    )
# </morphs>
# <display frames>
  stream.read(result.displayFramesCount)
  for _ in 1..result.displayFramesCount:
    result.displayFrames.add(
      stream.initDisplayFrame(
        result.header.globals.textEncoding,
        result.header.globals.boneIndexSize,
        result.header.globals.morphIndexSize
      )
    )
# </display frames>
# <rigid body>
  stream.read(result.rigidBodiesCount)
  for _ in 1..result.rigidBodiesCount:
    result.rigidBodies.add(
      stream.initRigidBody(
        result.header.globals.boneIndexSize,
        result.header.globals.textEncoding
      )
    )
# </rigid body>
# <joints>
  stream.read(result.jointsCount)
  for _ in 1..result.jointsCount:
    result.joints.add(
      stream.initJoint(
        result.header.globals.rigidbodyIndexSize,
        result.header.globals.textEncoding
      )
    )
# </joints>

# echo initPMXFile("testpmxs/test.pmx")
