import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/helpers/debouncer.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/widgets/base_header.dart';
import 'products_controller.dart';
import 'widgets/product_item.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with Loader, Messages {
  final controller = Modular.get<ProductsController>();
  final debouncer = Debouncer(milliseconds: 500);

  late final ReactionDisposer statusDisposer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      statusDisposer = reaction((p0) => controller.status, (status) async {
        switch (status) {
          case ProductStateStatus.initial:
            break;
          case ProductStateStatus.loading:
            showLoader();
            break;
          case ProductStateStatus.loaded:
            hideLoader();
            break;
          case ProductStateStatus.error:
            hideLoader();
            showError('Erro ao buscar produtos');
            break;
          case ProductStateStatus.addOrUpdatedProduct:
            hideLoader();
            var uri = '/products/detail';
            if (controller.productSelected != null) {
              uri += '?id=${controller.productSelected!.id}';
            }
            await Modular.to.pushNamed(uri);
            controller.loadProducts();

            break;
        }
      });
      controller.loadProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          BaseHeader(
            title: 'ADMINISTRAR PRODUTOS',
            buttomLabel: 'ADICIONAR PRODUTO',
            buttonPressed: () async {
              controller.addProduct();
            },
            searchChange: (value) {
              debouncer.call(() {
                controller.filterByName(value);
              });
            },
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    mainAxisSpacing: 20,
                    maxCrossAxisExtent: 280,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(product: controller.products[index]);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
