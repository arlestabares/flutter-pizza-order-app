import 'package:flutter/cupertino.dart';
import 'package:flutter_pizza_order_app/src/bloc/pizza_order_bloc.dart';

class PizzaOrderProvider extends InheritedWidget {
//
  final PizzaOrderBLoC bloc;
  final Widget child;

  PizzaOrderProvider({@required this.bloc, @required this.child}):super(child: child);

//Obtengo el bloc del ancestro mas cercano en el arbol de widgets.
static PizzaOrderBLoC of(BuildContext context) => context.findAncestorWidgetOfExactType<PizzaOrderProvider>().bloc;


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
