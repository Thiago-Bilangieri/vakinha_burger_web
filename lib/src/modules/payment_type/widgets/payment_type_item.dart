// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';
import '../payment_type_controller.dart';

class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeController _controller;
  const PaymentTypeItem({
    Key? key,
    required PaymentTypeController controller,
    required this.paymentTypeModel,
  })  : _controller = controller,
        super(key: key);
  final PaymentTypeModel paymentTypeModel;

  @override
  Widget build(BuildContext context) {
    final colorAll = paymentTypeModel.enabled ? Colors.black : Colors.grey;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/payment_${paymentTypeModel.acronym}_icon.png',
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/icons/payment_notfound_icon.png',
                  color: colorAll,
                );
              },
              color: colorAll,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      'Forma de pagamento',
                      style: context.textStyle.textRegular
                          .copyWith(color: colorAll),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Text(
                      paymentTypeModel.name,
                      style:
                          context.textStyle.textTitle.copyWith(color: colorAll),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    _controller.editPayment(paymentTypeModel);
                  },
                  child: Text(
                    'Editar',
                    style: context.textStyle.textMedium.copyWith(
                      color: paymentTypeModel.enabled
                          ? context.colors.prinary
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
