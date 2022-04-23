import std/[streams]
import pmxTypes, pmxText
import ../read

proc initMaterial*(s: Stream, textureIndexCount: int8, encoding: bool): Material =
  result.materialName.local = s.readText(encoding) # 0
  result.materialName.universal = s.readText(encoding) # 0
  s.read(result.diffuseColor)
  s.read(result.specularColor)
  s.read(result.specularStrength)
  s.read(result.ambientColor)
  result.drawingFlags = cast[MaterialFlags](s.readInt8())
  # 上面這個(line 9)我不知道對不對，先信這個吧
  # 因爲再pmxBones.nim裏面是要用`reversed`來處理flag(這中文啥hehe)的
  # 有pmx/mmd大佬給我查查嗎？
  # 如果知道的話就在nim (irc/discord/elements)那邊@我吧，
  # 謝大佬 Orz
  # 我是aph#8103 (discord)
  # I don't know if the code above is correct (line 9)
  # Because `pmxBones.nim` used `reversed` for flags, I'm worried that this won't create the correct flags
  # if you know the pmx/mmd file specification and about this in nim,
  # please contact me at nim's server! (irc/discord/elements)
  # many thanks! Orz
  # I'm aph#8103 (discord)
  s.read(result.edgeColor)
  s.read(result.edgeScale)
  result.textureIndex = s.readIndex(textureIndexCount)
  result.environmentIndex = s.readIndex(textureIndexCount)
  s.read(result.environmentBlendMode)
  s.read(result.toonReference)
  if result.toonReference == 0:
    result.toonValue = s.readInt8()
  else:
    result.toonValue = s.readIndex(textureIndexCount)
  result.metadata = s.readText(encoding)
  s.read(result.surfaceCount)