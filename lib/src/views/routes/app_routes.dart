import 'package:flutter/material.dart';
import 'package:flutter_pizza_order_app/src/views/pages/home_pizza_order_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'homePizzaOrderDetailsPage': (_) => HomePizzaOrderDetailPage()
};
