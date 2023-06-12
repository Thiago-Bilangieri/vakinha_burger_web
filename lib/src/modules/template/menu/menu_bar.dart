import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/helpers/history_back_listener.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import 'menu_button.dart';
import 'menu_enum.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> with HistoryBackListener {
  Menu? menuSelected;
  var colapsed = false;

  @override
  void onHistoryBack(Event event) {
    setState(() {
      menuSelected = Menu.findByPath(Modular.to.path);
    });
  }

  @override
  void initState() {
    menuSelected = Menu.findByPath(Modular.to.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: colapsed ? 90 : context.percentWidth(.18),
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: colapsed ? Alignment.center : Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  colapsed = !colapsed;
                });
              },
              icon: Icon(
                !colapsed
                    ? Icons.keyboard_double_arrow_left
                    : Icons.keyboard_double_arrow_right,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final menu = Menu.values[index];
              return MenuButton(
                menu: menu,
                selectedMenu: menuSelected,
                onPressed: (novoMenu) {
                  setState(() {
                    menuSelected = novoMenu;
                    Modular.to.navigate(menu.route);
                  });
                },
              );
            },
            itemCount: Menu.values.length,
          )
        ],
      ),
    );
  }
}
