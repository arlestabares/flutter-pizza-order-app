import 'package:flutter/material.dart';
import 'package:flutter_pizza_order_app/src/views/routes/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'homePizzaOrderDetailsPage',
      routes: appRoutes,
    );
  }
}
