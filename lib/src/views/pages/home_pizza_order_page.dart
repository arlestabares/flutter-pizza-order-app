import 'package:flutter/material.dart';
import 'package:flutter_pizza_order_app/src/data/models/ingredients_model.dart';


const double _pizzaCartSize = 55.0;

class HomePizzaOrderDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Orleans Pizza',
            style: TextStyle(color: Colors.brown, fontSize: 24),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              color: Colors.brown,
              onPressed: () {},
            )
          ],
        ),
        body: Stack(children: [
          //Positioned.fill(), permite darle valores de separacion lateralmente.
          Positioned.fill(
            bottom: 50,
            left: 10,
            right: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Column(
                children: [
                  Expanded(flex: 3, child: _PizzaDetails()),
                  Expanded(flex: 2, child: _PizzaIngredients()),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 40,
              width: _pizzaCartSize,
              height: _pizzaCartSize,
              left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
              child: _PizzaCartButton())
        ]));
  }
}

class _PizzaDetails extends StatefulWidget {
  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails> {
  final _listaIngredients = <Ingredient>[];
  final _notifierFocused = ValueNotifier(false);

  int _total = 15;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: DragTarget<Ingredient>(onAccept: (ingredient) {
          print('onAccept');
          _notifierFocused.value = false;
          setState(() {
            _listaIngredients.add(ingredient);
            _total++;
          });
        }, onWillAccept: (ingredient) {
          print('onWillAccept');

          _notifierFocused.value = true;
          // _listaIngredients.add(ingredient);

          for (Ingredient i in _listaIngredients) {
            if (i.compare(ingredient)) {
              return false;
            }
          }

          // _listaIngredients.add(ingredient);
          return true;
        }, onLeave: (ingredient) {
          print('onLeave');
          _notifierFocused.value = false;

          //
        }, builder: (context, list, reject) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              //widget que escuchara las notificaciones de cambio del _notifierFocused.
              child: ValueListenableBuilder<bool>(
                valueListenable: _notifierFocused,
                builder: (BuildContext context, focused, _) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    height: focused
                        ? constraints.maxHeight
                        : constraints.maxHeight - 40,
                    child: Stack(
                      children: [
                        Image.asset('assets/dish.png'),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset('assets/pizza-1.png'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          });
        })),
        const SizedBox(height: 25),

        //Animacion del texto Numerico del precio.
        AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(Tween<Offset>(
                    begin: Offset(0.0, 0.0),
                    end: Offset(
                      0.0,
                      animation.value,
                    ))),
                child: child,
              ),
            );
          },
          child: Text(
            '\$$_total',
            // key: UniqueKey(),
            key: Key(_total.toString()),
            style: TextStyle(
                color: Colors.brown, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class _PizzaCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.withOpacity(0.5), Colors.orange])),
      child: Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}

class _PizzaIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return _PizzaIngredientsItem(ingredient: ingredient);
      },
    );
  }
}

class _PizzaIngredientsItem extends StatelessWidget {
  final Ingredient ingredient;

  const _PizzaIngredientsItem({this.ingredient});
  @override
  Widget build(BuildContext context) {
    final child = Container(
        width: 50,
        height: 50,
        decoration:
            BoxDecoration(color: Color(0xFFF5EED3), shape: BoxShape.circle),
        child: Padding(
            padding: const EdgeInsets.all(3),
            child: Image.asset(
              ingredient.image,
              fit: BoxFit.contain,
            )));

    return Center(
      child: Draggable(
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
            child: child,
          ),
          data: ingredient,
          child: child),
    );
  }
}
