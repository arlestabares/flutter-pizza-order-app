import 'package:flutter/material.dart';


class PizzaCartButton extends StatefulWidget {
  final VoidCallback ontap;

  const PizzaCartButton({Key key, this.ontap}) : super(key: key);

  @override
  _PizzaCartButtonState createState() => _PizzaCartButtonState();
}

class _PizzaCartButtonState extends State<PizzaCartButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 1.0,
        upperBound: 1.5,
        duration: Duration(milliseconds: 100),
        reverseDuration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _animationButtonController() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.ontap();
          _animationButtonController();
        },
        child: AnimatedBuilder(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange.withOpacity(0.5), Colors.orange]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    //radio de propagacion
                    spreadRadius: 4.0,
                    //radio de desenfoque
                    blurRadius: 15.0,
                    //
                    offset: Offset(0.0, 4.0),
                  ),
                ]),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          animation: _animationController,
          builder: (context, child) {
            //Transformacion para el boton del boton compra
            return Transform.scale(
              //clamp() = abrazadera, mordaza
              // scale: (2 - _animationController.value).clamp(0.5, 1.0),
              scale: (2 - _animationController.value),
              child: child,
            );
          },
        ));
  }
}
