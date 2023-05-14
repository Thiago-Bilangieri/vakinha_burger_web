import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../models/payment_type_model.dart';
import 'payment_type_controller.dart';
import 'widgets/paymentTypeForm/payment_type_form_modal.dart';
import 'widgets/payment_type_header.dart';
import 'widgets/payment_type_item.dart';

class PaymentTypePage extends StatefulWidget {
  const PaymentTypePage({Key? key}) : super(key: key);

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage>
    with Loader, Messages {
  final controller = Modular.get<PaymentTypeController>();
  final disposers = <ReactionDisposer>[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final filterDisposer = reaction((p0) => controller.filterEnabled, (p0) {
        controller.loadPayment();
      });
      final statusDiposer = reaction((p0) => controller.status, (status) {
        switch (status) {
          case PaymentTypeStateStatus.initial:
            break;
          case PaymentTypeStateStatus.loading:
            showLoader();
            break;
          case PaymentTypeStateStatus.loaded:
            hideLoader();
            break;
          case PaymentTypeStateStatus.error:
            hideLoader();
            showError(
              controller.errorMessage ?? 'Erro ao buscar formas de pagamentos',
            );
            break;
          case PaymentTypeStateStatus.addOrUpdatePayment:
            hideLoader();
            showAddOrUpdatePayment();
            break;
          case PaymentTypeStateStatus.saved:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            controller.loadPayment();
            break;
        }
      });
      disposers.addAll([statusDiposer, filterDisposer]);
      controller.loadPayment();
    });
    super.initState();
  }

  @override
  void dispose() {
    for (final disposer in disposers) {
      disposer();
    }
    super.dispose();
  }

  void showAddOrUpdatePayment() {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: PaymentTypeFormModal(
              model: controller.paymentTypeModel,
              controller: controller,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[59],
      padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          PaymentTypeHeader(
            controller: controller,
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return GridView.builder(
                  itemCount: controller.paymentTypes.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 680,
                    mainAxisExtent: 120,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final PaymentTypeModel payment =
                        controller.paymentTypes[index];
                    return PaymentTypeItem(
                      controller: controller,
                      paymentTypeModel: payment,
                    );
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