import 'package:flutter/material.dart';
import 'package:flutter_pizza_order_app/src/bloc/pizza_order_bloc.dart';
import 'package:flutter_pizza_order_app/src/data/models/ingredients_model.dart';
import 'package:flutter_pizza_order_app/src/providers/pizza_order_provider.dart';
import 'package:flutter_pizza_order_app/src/views/widgets/pizza_cart_button.dart';
import 'package:flutter_pizza_order_app/src/views/widgets/pizza_size_button.dart';
import 'package:flutter_pizza_order_app/src/views/widgets/widgets.dart';

const double _pizzaCartSize = 55.0;

class HomePizzaOrderDetailPage extends StatelessWidget {
  final bloc = PizzaOrderBLoC();

  @override
  Widget build(BuildContext context) {
    return PizzaOrderProvider(
      bloc: bloc,
      child: Scaffold(
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
        body: Stack(
          children: [
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
                    SizedBox(height: 10),
                    Expanded(flex: 3, child: _PizzaDetails()),
                    Expanded(flex: 2, child: PizzaIngredients()),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              width: _pizzaCartSize,
              height: _pizzaCartSize,
              left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
              child: PizzaCartButton(
                ontap: () {
                  print('pizaCartButton');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PizzaDetails extends StatefulWidget {
  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with TickerProviderStateMixin {
  //

  final _notifierFocused = ValueNotifier(false);

  AnimationController _animationController;
  AnimationController _animationRotatinController;
  List<Animation> _animationList = <Animation>[];
  BoxConstraints _pizzaConstraints;
  //Variable que notificara de los cambios al seleccionar el tamano de la pizza.
  final _notifierPizzaSizeState =
      ValueNotifier<_PizzaSizeState>(_PizzaSizeState(_PizzaSizeValue.m));

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animationRotatinController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationRotatinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = PizzaOrderProvider.of(context);
    return Column(
      children: [
        Expanded(
            child: DragTarget<Ingredient>(onAccept: (ingredient) {
          print('onAccept');
          _notifierFocused.value = false;
          //Invocamos al BLoC y agregamos el ingrediente.
          bloc.addIngredient(ingredient);
          //
          _buildIngredientsAnimation();
          _animationController.forward(from: 0.0);

          //
        }, onWillAccept: (ingredient) {
          print('onWillAccept');
          _notifierFocused.value = true;

          return !bloc.containsIngredient(ingredient);
          //
        }, onLeave: (ingredient) {
          print('onLeave');
          _notifierFocused.value = false;

          //
        }, builder: (context, list, reject) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            //_pizzaConstraints para saber cuanto tiene de espacio disponible
            _pizzaConstraints = constraints;
            print(_pizzaConstraints);
            //ValueListenableBuilder, para la escucha globlal de cambio de tamano de la pizza y que asi mismo
            //la pizza cambie al tamano solicitado.
            return ValueListenableBuilder<_PizzaSizeState>(
                valueListenable: _notifierPizzaSizeState,
                builder: (context, pizzaSize, _) {
                  return RotationTransition(
                    turns: CurvedAnimation(
                      parent: _animationRotatinController,
                      curve: Curves.bounceIn,
                    ),
                    child: Stack(children: [
                      Center(
                        //widget que escuchara las notificaciones de cambio del _notifierFocused para que aumente o dismuya de tamano.
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _notifierFocused,
                          builder: (BuildContext context, focused, _) {
                            //Animacion del Tamano de la pizza para aumentar y disminuir de tamano al caerle los ingredientes.
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: focused
                                  ? constraints.maxHeight * pizzaSize.factor
                                  : constraints.maxHeight * pizzaSize.factor -
                                      20.0,
                              child: Stack(
                                children: [
                                  DecoratedBox(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10.0,
                                              spreadRadius: 5.0,
                                              color: Colors.black26,
                                              offset: Offset(0.0, 3.0),
                                            )
                                          ]),
                                      child: Image.asset('assets/dish.png')),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.asset('assets/pizza-1.png'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      //Escucha para notificar valores de cambio dentro de la animacion de
                      //los valores eliminados.
                      ValueListenableBuilder<Ingredient>(
                        valueListenable: bloc.notifierDeleteIngredient,
                        builder: (context, deletIngredient, _) {
                          _animateDeletedIngredient(deletIngredient);
                          //Animacion de los ingredientes cuando son agregados a la pizza.
                          return AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, _) {
                              //
                              return _builIngredientsWidget(deletIngredient);
                            },
                          );
                        },
                      )
                    ]),
                  );
                });
          });
        })),
        const SizedBox(height: 30),

        //Animacion del texto Numerico del precio.
        ValueListenableBuilder<int>(
            valueListenable: bloc.notifierTotal,
            builder: (context, totalValue, _) {
              return AnimatedSwitcher(
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
                  '\$$totalValue',
                  key: UniqueKey(),
                  // key: Key(_total.toString()),
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              );
            }),
        SizedBox(height: 15),
        ValueListenableBuilder<_PizzaSizeState>(
          valueListenable: _notifierPizzaSizeState,
          builder: (context, pizzaButtonSize, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PizzaSizeButton(
                  text: 'S',
                  selected: pizzaButtonSize.value == _PizzaSizeValue.s,
                  onTap: () {
                    _updatePizzaSize(_PizzaSizeValue.s);
                  },
                ),
                PizzaSizeButton(
                    text: 'M',
                    selected: pizzaButtonSize.value == _PizzaSizeValue.m,
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.m);
                    }),
                PizzaSizeButton(
                    text: 'L',
                    selected: pizzaButtonSize.value == _PizzaSizeValue.l,
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.l);
                    }),
              ],
            );
          },
        )
      ],
    );
  }

  //
  void _buildIngredientsAnimation() {
    _animationList.clear();
    _animationList.add(CurvedAnimation(
        curve: Interval(0.0, 0.8, curve: Curves.decelerate),
        parent: _animationController));

    _animationList.add(CurvedAnimation(
        curve: Interval(0.2, 0.8, curve: Curves.decelerate),
        parent: _animationController));

    _animationList.add(CurvedAnimation(
        curve: Interval(0.4, 1.0, curve: Curves.decelerate),
        parent: _animationController));

    _animationList.add(CurvedAnimation(
        curve: Interval(0.1, 0.9, curve: Curves.decelerate),
        parent: _animationController));

    _animationList.add(CurvedAnimation(
        curve: Interval(0.3, 1.0, curve: Curves.decelerate),
        parent: _animationController));
  }

//Widget encargado de la Animacion de los ingredientes cayendo sobre la pizza.
  Widget _builIngredientsWidget(Ingredient deletedIngredient) {
    //Retornamos la lista de elementos  en una Stack(), al final del metodo.
    List<Widget> elements = [];
    //Proveedor de ESTADOS BLoC.
    //creo una listIngredients nueva, sobre otra que ya existe para no afectar los elementos que ya estan dentro.
    final listIngredients =
        List.from(PizzaOrderProvider.of(context).listaIngredients);

    if (deletedIngredient != null) {
      //Agrega el elemento eliminado al final de la lista. Y ese es el que sera animado
      //para sacarlo de la lista.
      listIngredients.add(deletedIngredient);
    }

    if (_animationList.isNotEmpty) {
      for (int i = 0; i < listIngredients.length; i++) {
        //
        Ingredient ingredient = listIngredients[i];
        final ingredientWidget = Image.asset(ingredient.image, height: 20);
        //
        for (int j = 0; j < ingredient.positions.length; j++) {
          //
          final animation = _animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;

          //Logica para animar el ultimo ingrediente agregado a la pizza, de lo contrario
          //en el  else  no los anima.,,,,,,La segunda condicion _animationController.isAnimating
          //es la encargada de sacar el ingrediente de la pizza cuando se desea borrar de la  misma.
          if (i == listIngredients.length - 1 &&
              _animationController.isAnimating) {
            double fromX = 0.0, fromY = 0.0;

            if (j < 1) {
              fromX = -_pizzaConstraints.maxWidth *
                  (1 - animation.value); // obtener el ancho máximo disponible
            } else if (j < 2) {
              fromX = -_pizzaConstraints.maxWidth *
                  (1 - animation.value); // obtener el ancho máximo disponible
            } else if (j < 4) {
              fromY = _pizzaConstraints.maxHeight *
                  (1 - animation.value); // obtener la altura máxima disponible
            } else {
              fromY = _pizzaConstraints.maxHeight *
                  (1 - animation.value); // obtener la altura máxima disponible
            }

            // Transformamos los elementos o ingredientes para animarlos cayendo en posiciones especificas.
            //Podemos darle opacidad a los ingredientes cuando se animan.
            final opacity = animation.value;
            if (animation.value > 0) {
              elements.add(Opacity(
                opacity: opacity,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(fromX + _pizzaConstraints.maxWidth * positionX,
                        fromY + _pizzaConstraints.maxHeight * positionY),
                  child: ingredientWidget,
                ),
              ));
            }
          }
          //Aqui, si la animacion no esta lanzada, simplemente pinta los elementos tal como estan.
          else {
            elements.add(Transform(
              transform: Matrix4.identity()
                ..translate(_pizzaConstraints.maxWidth * positionX,
                    _pizzaConstraints.maxHeight * positionY),
              child: ingredientWidget,
            ));
          }
        }
      }
      return Stack(
        children: elements,
      );
    }
    return SizedBox.fromSize();
  }


//Future para la animacion del elemento eliminado.
  Future<void> _animateDeletedIngredient(Ingredient deletedIngredient) async {
    if (deletedIngredient != null) {
      //Esta animacion solo se lanzara cuando el elemento borrado sea nulo.
      await _animationController.reverse();
      final bloc = PizzaOrderProvider.of(context);
      bloc.refreshDeletedIngredient();
    }
  }

  void _updatePizzaSize(_PizzaSizeValue value) {
    _notifierPizzaSizeState.value = _PizzaSizeState(value);
    _animationRotatinController.forward(from: 0.0);
  }
}

enum _PizzaSizeValue {
  s,
  m,
  l,
}

class _PizzaSizeState {
  final _PizzaSizeValue value;
  final double factor;

  _PizzaSizeState(this.value) : factor = _getFactorBySize(value);

  static _getFactorBySize(_PizzaSizeValue value) {
    switch (value) {
      case _PizzaSizeValue.s:
        return 0.75;
      case _PizzaSizeValue.m:
        return 0.9;
      case _PizzaSizeValue.l:
        return 1.05;

        break;
      default:
        return 1.0;
    }
  }
}
