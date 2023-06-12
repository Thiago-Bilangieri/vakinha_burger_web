// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';
import '../../../../dto/order/order_dto.dart';
import '../../../../models/orders/order_status.dart';
import '../../order_controller.dart';

class OrderBottomBar extends StatelessWidget {
  final OrderController controller;
  final OrderDto order;
  final VoidCallback? onPressed;
  const OrderBottomBar({
    super.key,
    required this.controller,
    required this.order,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        OrderBottomBarButtom(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          buttomColor: Colors.blue,
          buttomLabel: 'Finalizar',
          image: 'assets/images/icons/finish_order_white_ico.png',
          onPressed: order.status == OrderStatus.confirmado ? () => controller.changeStatus(OrderStatus.finalizado) : null,
        ),
        OrderBottomBarButtom(
          borderRadius: BorderRadius.zero,
          buttomColor: Colors.green,
          buttomLabel: 'Confirmar',
          image: 'assets/images/icons/confirm_order_white_icon.png',
          onPressed:  order.status == OrderStatus.pendente ? () =>controller.changeStatus(OrderStatus.confirmado) : null,
        ),
        OrderBottomBarButtom(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          buttomColor: Colors.red,
          buttomLabel: 'Cancelar',
          image: 'assets/images/icons/cancel_order_white_icon.png',
          onPressed:  order.status == OrderStatus.finalizado || order.status == OrderStatus.cancelado ? null : () => controller.changeStatus(OrderStatus.cancelado),
        ),
      ],
    );
  }
}

class OrderBottomBarButtom extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color buttomColor;
  final String buttomLabel;
  final String image;
  final VoidCallback? onPressed;
  const OrderBottomBarButtom({
    super.key,
    required this.borderRadius,
    required this.buttomColor,
    required this.buttomLabel,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            side: BorderSide(color: onPressed!= null? buttomColor : Colors.transparent),
            backgroundColor: buttomColor,
          ),
          onPressed: onPressed,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                buttomLabel,
                style: context.textStyle.textBold.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
