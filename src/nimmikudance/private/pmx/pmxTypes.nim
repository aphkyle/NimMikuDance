type Vec4* = array[4, float32]
type Vec3* = array[3, float32]
type Vec2* = array[2, float32]

# <text>
type 
  Text* = object
    local*, universal*: string
# </text>
# <deforms>
type
  Deforms* = ref RootObj
  Bdef1* = ref object of Deforms
    bone1Index* : int
    bone1Weight*: float
  Bdef2* = ref object of Deforms
    bone1Index*, bone2Index*: int
    bone1Weight*, bone2Weight*: float32
  Bdef4* = ref object of Deforms
    bone1Index*, bone2Index*, bone3Index*, bone4Index*: int
    bone1Weight*, bone2Weight*, bone3Weight*, bone4Weight*: float32
  Sdef* = ref object of Deforms
    bone1Index*, bone2Index*: int
    bone1Weight*, bone2Weight*: float32
    c0*, r0*, r1*: Vec3
  Qdef* = Bdef4
# </deforms>
# <vertex>
type Vertex* = object
  position*, normal*: Vec3
  uv*: Vec2
  additionalVec4*: seq[float32]
  weightDeformType*: uint8
  weightDeform*: Deforms
  edgeScale*: float32
# </vertext>
# <material>
type 
  MaterialFlag* {.size: 8 pure.} = enum
    mfNoCull
    mfGroundShadow
    mfDrawShadow
    mfReceiveShadow
    mfHasEdge
    mfVertexColor
    mfPointDrawing
    mfLineDrawing
  MaterialFlags* = set[MaterialFlag]

type Material* = object
  materialName*: Text
  diffuseColor*: Vec4
  specularColor*: Vec3
  specularStrength*: float32
  ambientColor*: Vec3
  drawingFlags*: MaterialFlags
  edgeColor*: Vec4
  edgeScale*: float32
  textureIndex*: int
  environmentIndex*: int
  environmentBlendMode*: int8
  toonReference*: int8
  toonValue*: int
  metaData*: string
  surfaceCount*: int32
# </material>
# <bones>
type
  TailPosition* = ref object of RootObj
  TPInt* = ref object of TailPosition
    value*: int
  TPVec3* = ref object of TailPosition
    value*: Vec3

type InheritBone* = object
  parentIndex*: int
  parentInfluence*: float32

type BoneLocalCoOrdinate* = object
  xVector*: Vec3
  zVector*: Vec3

type # IK
  IkAngleLimit* = object
    limitMin*: Vec3
    limitMax*: Vec3
  IkLinks* = object
    boneIndex*: int
    hasLimits*: int8
    ikAngleLimits*: IkAngleLimit
  BoneIk* = object
    targetIndex*: int
    loopCount*: int32
    limitRadian*: float32
    linkCount*: int32
    ikLinks*: seq[IkLinks]
  Bone* = object
    boneName*: Text
    position*: Vec3
    parentBoneIndex*: int
    layer*: int32
    flag*: int16
    tailPosition*: TailPosition
    inheritBone*: InheritBone
    fixedAxis*: Vec3
    localCoOrdinate*: BoneLocalCoOrdinate
    externalParent*: int
    ik*: BoneIk
# </bones>
# <morph>
type
  MorphOffsetData* = ref object of RootObj
  MorphGroup* = ref object of MorphOffsetData
    morphIndex*: int
    influence*: float32
  MorphVertex* = ref object of MorphOffsetData
    vertexIndex*: int
    translation*: Vec3
  MorphBone* = ref object of MorphOffsetData
    boneIndex*: int
    translation*: Vec3
    rotation*: Vec4
  MorphUv* = ref object of MorphOffsetData
    ext*: int # don't touch. this doesn't exist in the pmx file btw
    vertexIndex*: int
    floats*: Vec4 
  MorphMaterial* = ref object of MorphOffsetData
    materialIndex*: int
    calcMode*: int8
    diffuse*: Vec4
    specular*: Vec3
    specularity*: float32
    ambient*: Vec3
    edgeColor*: Vec4
    edgeSize*: float32
    textureTint*: Vec4
    environmentTint*: Vec4
    toonTint*: Vec4
  MorphFlip* = ref object of MorphOffsetData
    morphIndex*: int
    influence*: float32
  MorphImpulse* = ref object of MorphOffsetData
    rigidBodyIndex*: int
    localFlag*: int8
    movementSpeed*: Vec3
    rotationTorque*: Vec3
type Morph* = object
  morphName*: Text
  panelType*: int8
  morphType*: int8
  offsetSize*: int32
  offsetData*: seq[MorphOffsetData]
# </morph>
# <display frame>
type 
  FrameSlot* = ref object of RootObj
  BoneFrameSlot* = ref object of FrameSlot
    boneIndex*: int
  MorphFrameSlot* = ref object of FrameSlot
    morphIndex*: int
type Frame* = object
  frameType*: bool
  frameSlot*: FrameSlot
type DisplayFrame* = object
  displayFrameName*: Text
  specialFlag*: bool # false=normal, true=special
  frameCount*: int32
  frames*: seq[Frame]
# </display frame>
# <rigid body>
type RigidBody* = object
  rigidBodyName*: Text
  relatedBoneIndex*: int
  groupId*: int8
  nonCollisionGroup*: int16
  shape*: int8
  shapeSize*: Vec3
  shapePosition*: Vec3
  shapeRotation*: Vec3
  mass*: float32
  moveAttenuation*: float32
  rotationDamping*: float32
  repulsion*: float32
  frictionForce*: float32
  physicsMode*: int8
# </rigid body>
# <joint>
type Joint* = object
  jointName*: Text
  jointType*: int8
  rigidBodyIndexA*: int
  rigidBodyIndexB*: int
  position*: Vec3
  rotation*: Vec3
  positionMinimum*: Vec3
  positionMaximum*: Vec3
  rotationMinimum*: Vec3
  rotationMaximum*: Vec3
  positionSpring*: Vec3
  rotationSpring*: Vec3
# </joint>
# <file info>
type Globals* = object
  globalsCount*: uint8 # fixed at 8
  textEncoding*: bool
  additionalVec4Count*, vertexIndexSize*, textureIndexSize*, materialIndexSize*, boneIndexSize*, morphIndexSize*, rigidbodyIndexSize*: int8

type PMXHeader* = object
  signature*: string # "PMX "
  version*: float32 # 2.0, 2.1
  globals*: Globals
  modelName*: Text
  comments*: Text

type PMXFile* = object
  header*: PMXHeader
  verticesCount*: int32
  vertices*: seq[Vertex]
  surfacesCount*: int32
  surfaces*: seq[array[3, int]]
  texturesCount*: int32
  textures*: seq[string]
  materialsCount*: int32
  materials*: seq[Material]
  bonesCount*: int32
  bones*: seq[Bone]
  morphsCount*: int32
  morphs*: seq[Morph]
  displayFramesCount*: int32
  displayFrames*: seq[DisplayFrame]
  rigidBodiesCount*: int32
  rigidBodies*: seq[RigidBody]
  jointsCount*: int32
  joints*: seq[Joint]
# </file info>