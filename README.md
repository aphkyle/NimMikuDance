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
import nimmikudance/pmx

let myPmx = parsePMXFile("example.pmx")
echo myPmx.header.modelName
```

# version control
First digit for PMX\
Second digit for PMD\
Third for VMD\

`0` = non-complete/ no support for such file extension\
`1-5` = bug fixes\
`6`  = full support for the file extension\
`6+` = bug fixes\

So `0.0.0` = non-complete/no support for all extensions listed above.

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


contact email (i don't look through them very often): aphkyle@gmail.com
or you can contact me on discord, im aph#8103
