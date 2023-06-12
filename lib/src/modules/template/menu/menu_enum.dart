enum Menu {
  paymentType(
    '/payment-type/',
    'payment_type_icon.png',
    'payment_type_icon_selected.png',
    'Administrar Formas\nde Pagamentos',
  ),
  products(
    '/products/',
    'product_icon.png',
    'product_icon_selected.png',
    'Administrar Produtos',
  ),
  orders(
    '/order/',
    'order_icon.png',
    'order_icon_selected.png',
    'Pedidos do dia',
  );

  final String route;
  final String assetIcon;
  final String assetIconSelected;
  final String label;

  const Menu(this.route, this.assetIcon, this.assetIconSelected, this.label);

  static Menu? findByPath (String path){
    final menu = Menu.values.where((element) => path.contains(element.route));
    if(menu.isNotEmpty){
      return menu.first;
    }
    return null;
  }
}
