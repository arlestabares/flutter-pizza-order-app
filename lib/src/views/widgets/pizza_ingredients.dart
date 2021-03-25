part of 'widgets.dart';

class PizzaIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Jalo el bloc que tengo inyectado en el Widget principal
    final bloc = PizzaOrderProvider.of(context);

    //Hago un return de AnimatedBuilder que sirve tambien para escuchar objetos que extienden
    //de ChangeNotifier.
    return ValueListenableBuilder(
      //Escucho la notificacion del total...ya que cada vez que aumente o disminuya
      //refreco los elementos de la lista de ingredientes .
      valueListenable: bloc.notifierTotal,
      builder: (context, value, _) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              //
              final ingredient = ingredients[index];
              //
              return PizzaIngredientsItem(
                ingredient: ingredient,
                //hago una validacion, si lo contiene lo marco diferente con un borde.
                exist: bloc.containsIngredient(ingredient),
                onTap: () {
                  //removemos el ingrediente ingresado en la lista
                  bloc.removeIngredient(ingredient);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class PizzaIngredientsItem extends StatelessWidget {
  final Ingredient ingredient;
  final bool exist;
  final VoidCallback onTap;

  const PizzaIngredientsItem({
    @required this.ingredient,
    @required this.exist,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //Este Widget son los elementos Draggable.
    return Center(
      //Aqui, si el elemento o ingrediente existe, ya no podre arrarstrarlo de nuevo a la pizza,
      //de lo contrario podre arrastrarlo a la pizza .
      child: exist
          ? _buildChild()
          : Draggable(
              feedback: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.black26,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 5.0)
                  ],
                ),
                child: _buildChild(),
              ),
              data: ingredient,
              child: _buildChild(),
            ),
    );
  }

  Widget _buildChild() {
    //Este Widget son los elementos No Draggable.
    return GestureDetector(
      //
      onTap: exist ? onTap : null,
      //
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFF5EED3),
            shape: BoxShape.circle,
            //Aqui, si el elemento ya fue agregado le doy forma circular con borde,
            //de lo contrrio no tendra forma con borde definido.
            border: exist ? Border.all(color: Colors.green, width: 2) : null,
          ),
          child: Image.asset(
            ingredient.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
