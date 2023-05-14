import 'package:flutter_modular/flutter_modular.dart';

import 'home/products_page.dart';

class ProductsModule extends Module {

   @override
   List<Bind> get binds => [];

   @override
   List<ModularRoute> get routes => [
      ChildRoute('/', child: (context, args) => ProductsPage()),
      // ChildRoute('/datail', child: (context, args) => ProductsPage()),
   ];

}