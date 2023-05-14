import 'package:flutter/material.dart';

import '../../../../core/env/env.dart';
import '../../../../core/extension/formatter_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: constraints.maxHeight * .6,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${Env.instance.get('backend_base_url')}/storage/mclumygt_jrs_1682022574279.jpg',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'X-Tudão',
                  style: context.textStyle.textMedium,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(100.50.currencyPTBR),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Editar'),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
