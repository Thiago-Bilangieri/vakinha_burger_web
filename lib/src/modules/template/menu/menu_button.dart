import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import 'menu_enum.dart';

class MenuButton extends StatelessWidget {
  final Menu menu;
  final Menu? selectedMenu;
  final ValueChanged<Menu> onPressed;
  const MenuButton({
    super.key,
    required this.menu,
    this.selectedMenu,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedMenu == menu;
    return LayoutBuilder(
      builder: (_, constrains) {
        return Visibility(
          visible: constrains.maxWidth != 90,
          replacement: Container(
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFF5e2),
                  )
                : null,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            child: Tooltip(
              message: menu.label,
              child: IconButton(
                icon: Image.asset(
                  'assets/images/icons/${isSelected ? menu.assetIconSelected : menu.assetIcon}',
                ),
                onPressed: () => onPressed(menu),
              ),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onPressed(menu),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: isSelected
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFFF5e2),
                      )
                    : null,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/icons/${isSelected ? menu.assetIconSelected : menu.assetIcon}',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        menu.label,
                        overflow: TextOverflow.ellipsis,
                        style: isSelected
                            ? context.textStyle.textBold
                            : context.textStyle.textRegular,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
