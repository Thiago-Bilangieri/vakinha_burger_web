// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';

class OrderInfoTile extends StatelessWidget {
  final String label;
  final String info;
  const OrderInfoTile({
    super.key,
    required this.label,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: context.textStyle.textBold,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            info,
            style: context.textStyle.textMedium,
          ),
        ],
      ),
    );
  }
}
