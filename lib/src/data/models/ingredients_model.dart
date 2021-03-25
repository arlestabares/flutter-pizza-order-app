
import 'package:flutter/material.dart';

class Ingredient {
  final String image;
  final List<Offset> positions;
  const Ingredient(this.image, this.positions);

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredients = const <Ingredient>[
  Ingredient('assets/chili.png', <Offset>[
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65)
  ]),
  Ingredient('assets/olive_unit.png', <Offset>[
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.43, 0.5)
  ]),
  Ingredient('assets/onion.png', <Offset>[
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.43, 0.5)
  ]),
  Ingredient('assets/pea_unit.png', <Offset>[
    Offset(0.25, 0.5),
    Offset(0.65, 0.6),
    Offset(0.2, 0.3),
    Offset(0.4, 0.2),
    Offset(0.2, 0.6)
  ]),
  Ingredient('assets/pickle_unit.png', <Offset>[
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.25, 0.23),
    Offset(0.45, 0.35),
    Offset(0.4, 0.65)
  ]),
  Ingredient('assets/chili_unit.png', <Offset>[
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.43, 0.5)
  ]),
  Ingredient('assets/mushroom_unit.png', <Offset>[
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.23, 0.25),
    Offset(0.45, 0.35),
    Offset(0.43, 0.65)
  ]),
  Ingredient('assets/olive.png', <Offset>[
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65)
  ]),
  Ingredient('assets/potato_unit.png', <Offset>[
    Offset(0.2, 0.31),
    Offset(0.65, 0.25),
    Offset(0.3, 0.23),
    Offset(0.37, 0.26),
    Offset(0.43, 0.58)
  ]),
  Ingredient('assets/pickle.png', <Offset>[
    Offset(0.34, 0.39),
    Offset(0.65, 0.47),
    Offset(0.3, 0.29),
    Offset(0.4, 0.28),
    Offset(0.3, 0.49)
  ]),
];



