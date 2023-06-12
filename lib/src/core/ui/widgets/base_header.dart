import 'package:flutter/material.dart';

import '../helpers/size_extensions.dart';
import '../styles/text_styles.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final ValueChanged<String>? searchChange;
  final String buttomLabel;
  final VoidCallback? buttonPressed;
  final bool addButon;
  final Widget? filterWidget;

  const BaseHeader({
    super.key,
    required this.title,
    this.searchChange,
    this.buttomLabel = '',
    this.buttonPressed,
    this.addButon = true,
    this.filterWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) {
        return Wrap(
          children: [
            Visibility(
              visible: filterWidget == null,
              replacement: filterWidget ?? const SizedBox.shrink(),
              child: SizedBox(
                width: constrains.maxWidth * .15,
                child: TextFormField(enableInteractiveSelection: false,
                  onChanged: searchChange,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: Icon(
                      size: constrains.maxWidth * .02,
                      Icons.search_rounded,
                    ),
                    label: Text(
                      'Buscar',
                      style: context.textStyle.textRegular
                          .copyWith(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: constrains.maxWidth * .65,
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: context.textStyle.textTitle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                ),
              ),
            ),
            Visibility(
              visible: addButon == true,
              child: SizedBox(
                height: 48,
                width: constrains.maxWidth * .15,
                child: FittedBox(
                  child: OutlinedButton.icon(
                    onPressed: buttonPressed,
                    icon: const Icon(Icons.add),
                    label: context.screenWidth > 690
                        ? FittedBox(child: Text(buttomLabel))
                        : const Text(''),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
