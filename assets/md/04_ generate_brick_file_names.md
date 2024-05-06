## Generate brick file names

1. Add the `equatable` dependency as follows:

```console
$ flutter pub add equatable
```

2. Run the `generate_brick_file_names` command line tool as follows:

```console
$ dart run bin/generate_brick_file_names.dart
Map<BrickDamage, String> brickFileNames(BrickType type, BrickSize size) {
  return switch ((type, size)) {
    (BrickType.explosive, BrickSize.size140x70) => {
        BrickDamage.none: 'elementExplosive009.png',
        BrickDamage.some: 'elementExplosive012.png',
        BrickDamage.lots: 'elementExplosive050.png',
      },
    (BrickType.glass, BrickSize.size140x70) => {
        BrickDamage.none: 'elementGlass010.png',
        BrickDamage.some: 'elementGlass013.png',
        BrickDamage.lots: 'elementGlass048.png',
      },
    (BrickType.metal, BrickSize.size140x70) => {
        BrickDamage.none: 'elementMetal009.png',
        BrickDamage.some: 'elementMetal012.png',
        BrickDamage.lots: 'elementMetal050.png',
      },
    (BrickType.stone, BrickSize.size140x70) => {
        BrickDamage.none: 'elementStone009.png',
        BrickDamage.some: 'elementStone012.png',
        BrickDamage.lots: 'elementStone047.png',
      },
    (BrickType.wood, BrickSize.size140x70) => {
        BrickDamage.none: 'elementWood011.png',
        BrickDamage.some: 'elementWood014.png',
        BrickDamage.lots: 'elementWood054.png',
      },
    (BrickType.explosive, BrickSize.size70x70) => {
        BrickDamage.none: 'elementExplosive011.png',
        BrickDamage.some: 'elementExplosive014.png',
        BrickDamage.lots: 'elementExplosive049.png',
      },
    (BrickType.glass, BrickSize.size70x70) => {
        BrickDamage.none: 'elementGlass011.png',
        BrickDamage.some: 'elementGlass012.png',
        BrickDamage.lots: 'elementGlass046.png',
      },
    (BrickType.metal, BrickSize.size70x70) => {
        BrickDamage.none: 'elementMetal011.png',
        BrickDamage.some: 'elementMetal014.png',
        BrickDamage.lots: 'elementMetal049.png',
      },
    (BrickType.stone, BrickSize.size70x70) => {
        BrickDamage.none: 'elementStone011.png',
        BrickDamage.some: 'elementStone014.png',
        BrickDamage.lots: 'elementStone046.png',
      },
    (BrickType.wood, BrickSize.size70x70) => {
        BrickDamage.none: 'elementWood010.png',
        BrickDamage.some: 'elementWood013.png',
        BrickDamage.lots: 'elementWood045.png',
      },
    (BrickType.explosive, BrickSize.size220x70) => {
        BrickDamage.none: 'elementExplosive013.png',
        BrickDamage.some: 'elementExplosive016.png',
        BrickDamage.lots: 'elementExplosive051.png',
      },
    (BrickType.glass, BrickSize.size220x70) => {
        BrickDamage.none: 'elementGlass014.png',
        BrickDamage.some: 'elementGlass017.png',
        BrickDamage.lots: 'elementGlass049.png',
      },
    (BrickType.metal, BrickSize.size220x70) => {
        BrickDamage.none: 'elementMetal013.png',
        BrickDamage.some: 'elementMetal016.png',
        BrickDamage.lots: 'elementMetal051.png',
      },
    (BrickType.stone, BrickSize.size220x70) => {
        BrickDamage.none: 'elementStone013.png',
        BrickDamage.some: 'elementStone016.png',
        BrickDamage.lots: 'elementStone048.png',
      },
    (BrickType.wood, BrickSize.size220x70) => {
        BrickDamage.none: 'elementWood012.png',
        BrickDamage.some: 'elementWood015.png',
        BrickDamage.lots: 'elementWood047.png',
      },
    (BrickType.explosive, BrickSize.size70x140) => {
        BrickDamage.none: 'elementExplosive017.png',
        BrickDamage.some: 'elementExplosive022.png',
        BrickDamage.lots: 'elementExplosive052.png',
      },
    (BrickType.glass, BrickSize.size70x140) => {
        BrickDamage.none: 'elementGlass018.png',
        BrickDamage.some: 'elementGlass023.png',
        BrickDamage.lots: 'elementGlass050.png',
      },
    (BrickType.metal, BrickSize.size70x140) => {
        BrickDamage.none: 'elementMetal017.png',
        BrickDamage.some: 'elementMetal022.png',
        BrickDamage.lots: 'elementMetal052.png',
      },
    (BrickType.stone, BrickSize.size70x140) => {
        BrickDamage.none: 'elementStone017.png',
        BrickDamage.some: 'elementStone022.png',
        BrickDamage.lots: 'elementStone049.png',
      },
    (BrickType.wood, BrickSize.size70x140) => {
        BrickDamage.none: 'elementWood016.png',
        BrickDamage.some: 'elementWood021.png',
        BrickDamage.lots: 'elementWood048.png',
      },
    (BrickType.explosive, BrickSize.size140x140) => {
        BrickDamage.none: 'elementExplosive018.png',
        BrickDamage.some: 'elementExplosive023.png',
        BrickDamage.lots: 'elementExplosive053.png',
      },
    (BrickType.glass, BrickSize.size140x140) => {
        BrickDamage.none: 'elementGlass019.png',
        BrickDamage.some: 'elementGlass024.png',
        BrickDamage.lots: 'elementGlass051.png',
      },
    (BrickType.metal, BrickSize.size140x140) => {
        BrickDamage.none: 'elementMetal018.png',
        BrickDamage.some: 'elementMetal023.png',
        BrickDamage.lots: 'elementMetal053.png',
      },
    (BrickType.stone, BrickSize.size140x140) => {
        BrickDamage.none: 'elementStone018.png',
        BrickDamage.some: 'elementStone023.png',
        BrickDamage.lots: 'elementStone050.png',
      },
    (BrickType.wood, BrickSize.size140x140) => {
        BrickDamage.none: 'elementWood017.png',
        BrickDamage.some: 'elementWood022.png',
        BrickDamage.lots: 'elementWood049.png',
      },
    (BrickType.explosive, BrickSize.size220x140) => {
        BrickDamage.none: 'elementExplosive019.png',
        BrickDamage.some: 'elementExplosive024.png',
        BrickDamage.lots: 'elementExplosive054.png',
      },
    (BrickType.glass, BrickSize.size220x140) => {
        BrickDamage.none: 'elementGlass020.png',
        BrickDamage.some: 'elementGlass025.png',
        BrickDamage.lots: 'elementGlass052.png',
      },
    (BrickType.metal, BrickSize.size220x140) => {
        BrickDamage.none: 'elementMetal019.png',
        BrickDamage.some: 'elementMetal024.png',
        BrickDamage.lots: 'elementMetal054.png',
      },
    (BrickType.stone, BrickSize.size220x140) => {
        BrickDamage.none: 'elementStone019.png',
        BrickDamage.some: 'elementStone024.png',
        BrickDamage.lots: 'elementStone051.png',
      },
    (BrickType.wood, BrickSize.size220x140) => {
        BrickDamage.none: 'elementWood018.png',
        BrickDamage.some: 'elementWood023.png',
        BrickDamage.lots: 'elementWood050.png',
      },
    (BrickType.explosive, BrickSize.size70x220) => {
        BrickDamage.none: 'elementExplosive020.png',
        BrickDamage.some: 'elementExplosive025.png',
        BrickDamage.lots: 'elementExplosive055.png',
      },
    (BrickType.glass, BrickSize.size70x220) => {
        BrickDamage.none: 'elementGlass021.png',
        BrickDamage.some: 'elementGlass026.png',
        BrickDamage.lots: 'elementGlass053.png',
      },
    (BrickType.metal, BrickSize.size70x220) => {
        BrickDamage.none: 'elementMetal020.png',
        BrickDamage.some: 'elementMetal025.png',
        BrickDamage.lots: 'elementMetal055.png',
      },
    (BrickType.stone, BrickSize.size70x220) => {
        BrickDamage.none: 'elementStone020.png',
        BrickDamage.some: 'elementStone025.png',
        BrickDamage.lots: 'elementStone052.png',
      },
    (BrickType.wood, BrickSize.size70x220) => {
        BrickDamage.none: 'elementWood019.png',
        BrickDamage.some: 'elementWood024.png',
        BrickDamage.lots: 'elementWood051.png',
      },
    (BrickType.explosive, BrickSize.size140x220) => {
        BrickDamage.none: 'elementExplosive021.png',
        BrickDamage.some: 'elementExplosive026.png',
        BrickDamage.lots: 'elementExplosive056.png',
      },
    (BrickType.glass, BrickSize.size140x220) => {
        BrickDamage.none: 'elementGlass022.png',
        BrickDamage.some: 'elementGlass027.png',
        BrickDamage.lots: 'elementGlass054.png',
      },
    (BrickType.metal, BrickSize.size140x220) => {
        BrickDamage.none: 'elementMetal021.png',
        BrickDamage.some: 'elementMetal026.png',
        BrickDamage.lots: 'elementMetal056.png',
      },
    (BrickType.stone, BrickSize.size140x220) => {
        BrickDamage.none: 'elementStone021.png',
        BrickDamage.some: 'elementStone026.png',
        BrickDamage.lots: 'elementStone053.png',
      },
    (BrickType.wood, BrickSize.size140x220) => {
        BrickDamage.none: 'elementWood020.png',
        BrickDamage.some: 'elementWood025.png',
        BrickDamage.lots: 'elementWood052.png',
      },
  };
}
```