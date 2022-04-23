# NMD

[![nimble](https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png)](https://github.com/yglukhov/nimble-tag)

Nim ♥ MMD = NMD!

Made with Nim & ♥

Lets parse all that MMDs!

Features:
|      | PMX 2.0 | PMD | VMD |
|:----:|:-------:|:---:|:---:|
| Read | ✔️      | ❌ | ❌ |
| Write| ❌      | ❌ | ❌ |

please issue if there's more mmd formats!

# how to use?
```nim
import nmd/pmx

let myPmx = initPMXFile("example.pmx")
echo myPmx.vertices
```

# version control
version `0.0.0` is alpha (not stable yet)

`0.1.x` should support all of pmx

`1.x.x` should support pmd

`2.x.x` should support vmd

`3.x.x` should support javascript backend

first x = major updates

second x = +features

third x = bug fix

## how can I help?
- send me a few samples of pmx 2.1 (contact me on nim's server, i'm aph#8103)
- do the todos
- correct my typos

## smOl ToDO
- check if the flags are actually correct and use better ways than `tobin`
## bIG tODO
- support pmx 2.1 (yay, softbodies)
- add pmd/vmd support
- (unrelated) make a viewer based on this



ps: i like xml,
blame me for those `<start>` `</end>` stuff,
i don't know what are better ways to state those, 

please issue on those typos or development related things!
help is greatly appreciated!