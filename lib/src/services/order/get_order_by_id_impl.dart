import '../../dto/order/order_dto.dart';
import '../../dto/order/order_product_dto.dart';
import '../../models/orders/order_model.dart';
import '../../models/payment_type_model.dart';
import '../../models/user_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
import '../../repositories/products/product_repository.dart';
import '../../repositories/user/user_repository.dart';
import './get_order_by_id.dart';

class GetOrderByIdImpl extends GetOrderById {
  final PaymentTypeRepository _paymentTypeRepository;
  final UserRepository _userRepository;
  final ProductRepository _productRepository;

  GetOrderByIdImpl(
    this._paymentTypeRepository,
    this._userRepository,
    this._productRepository,
  );

  @override
  Future<OrderDto> call(OrderModel order) {
    return _orderDtoParse(order);
  }

  Future<OrderDto> _orderDtoParse(OrderModel orderModel) async {
    final paymentTypeFuture =
        _paymentTypeRepository.getById(orderModel.paymentTypeId);
    final userFuture = _userRepository.getById(orderModel.userId);
    final orderProductsFuture = _orderProductsParse(orderModel);

    final responses =
        await Future.wait([paymentTypeFuture, userFuture, orderProductsFuture]);

   
    return OrderDto(
      id: orderModel.id,
      date: orderModel.date,
      status: orderModel.status,
      orderProducts: responses[2] as List<OrderProductDto>,
      user: responses[1] as UserModel,
      address: orderModel.address,
      cpf: orderModel.cpf,
      paymentTypeModel: responses[0] as PaymentTypeModel,
    );
  }

  Future<List<OrderProductDto>> _orderProductsParse(
    OrderModel orderModel,
  ) async {
    final orderProducts = <OrderProductDto>[];
    final productsFuture = orderModel.orderProducts
        .map((e) => _productRepository.getProduct(e.productId))
        .toList();

    final products = await Future.wait(productsFuture);

    for (var i = 0; i < orderModel.orderProducts.length; i++) {
      final orderProduct = orderModel.orderProducts[i];
      final productsDto = OrderProductDto(
        product: products[i],
        amount: orderProduct.amount,
        totalPrice: orderProduct.totalPrice,
      );

      orderProducts.add(productsDto);
    }
    return orderProducts;
  }
}
