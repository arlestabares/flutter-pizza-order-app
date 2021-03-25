class Ingredient {
final String image;
const Ingredient(this.image);

bool compare(Ingredient ingredient)=> ingredient.image == image;

}

final ingredients = const<Ingredient> [
Ingredient('assets/chili.png'),
Ingredient('assets/olive_unit.png'),
Ingredient('assets/onion.png'),
Ingredient('assets/pea_unit.png'),
Ingredient('assets/pickle_unit.png'),
Ingredient('assets/chili_unit.png'),
Ingredient('assets/mushroom_unit.png'),
Ingredient('assets/olive.png'),
Ingredient('assets/potato_unit.png'),
Ingredient('assets/pickle.png'),

];