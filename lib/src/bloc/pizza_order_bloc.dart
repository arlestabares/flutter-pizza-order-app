import 'package:flutter/foundation.dart' show ChangeNotifier, ValueNotifier;
import 'package:flutter_pizza_order_app/src/data/models/ingredients_model.dart';

class PizzaOrderBLoC extends ChangeNotifier {
  final listaIngredients = <Ingredient>[];
  final notifierTotal = ValueNotifier(15);
  

  //Especifico el Tipo en el ValueNotifier<>
  final notifierDeleteIngredient = ValueNotifier<Ingredient>(null);

  void addIngredient(Ingredient ingredient) {
    listaIngredients.add(ingredient);
    notifierTotal.value++;
  }

  void removeIngredient(Ingredient ingredient) {
    listaIngredients.remove(ingredient);
    notifierDeleteIngredient.value = ingredient;
    notifierTotal.value--;
  }

  void refreshDeletedIngredient() {
    //Hago nulo o limpio el elemento para cuando haga otra animacion no aparezca de nuevo.
    notifierDeleteIngredient.value = null;
  }

//Para saber si contiene el ingrediente llegado por parametro
  bool containsIngredient(Ingredient ingredient) {
    for (Ingredient i in listaIngredients) {
      if (i.compare(ingredient)) {
        return true;
      }
    }
    return false;
  }
}
