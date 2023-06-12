import 'package:flutter/material.dart';

import '../../../core/extension/formatter_extensions.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../dto/order/order_dto.dart';
import '../order_controller.dart';
import 'widgets/order_bottom_bar.dart';
import 'widgets/order_info_tile.dart';
import 'widgets/order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  final OrderController controller;
  final OrderDto orderDto;
  const OrderDetailModal({
    super.key,
    required this.controller,
    required this.orderDto,
  });

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void _closeModal() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(30),
          width: screenWidth * (screenWidth > 1200 ? .5 : .7),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detalhe do Pedido',
                        style: context.textStyle.textTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: _closeModal,
                        icon: const Icon(Icons.close),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Nome do Cliente',
                      style: context.textStyle.textBold,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.orderDto.user.name,
                      style: context.textStyle.textRegular,
                    ),
                  ],
                ),
                const Divider(),
                ...widget.orderDto.orderProducts
                    .map(
                      (e) => OrderProductItem(
                        orderProduct: e,
                      ),
                    )
                    .toList(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total do pedido:',
                      style: context.textStyle.textExtraBold.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.orderDto.orderProducts
                          .fold<double>(
                            0.0,
                            (previusValue, element) =>
                                previusValue + element.totalPrice,
                          )
                          .currencyPTBR,
                      style: context.textStyle.textExtraBold.copyWith(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                const Divider(),
                OrderInfoTile(
                  label: 'Endereço de Entrega:',
                  info: widget.orderDto.address,
                ),
                const Divider(),
                OrderInfoTile(
                  label: 'Forma de Pagamento:',
                  info: widget.orderDto.paymentTypeModel.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                OrderBottomBar(
                  controller: widget.controller,
                  order: widget.orderDto,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
