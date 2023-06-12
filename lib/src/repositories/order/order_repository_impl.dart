import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/orders/order_model.dart';
import '../../models/orders/order_status.dart';
import './order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final CustomDio _dio;

  OrderRepositoryImpl(this._dio);

  @override
  Future<void> changeStatus(int id, OrderStatus status) async {
    try {
      await _dio.auth().put('/orders/$id', data: {'status': status.acronym});
    } on DioError catch (e, s) {
      log(
        'Erro ao alterar o status do pedido paraa ${status.name}',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao alterar o status do pedido paraa ${status.name}',
      );
    }
  }

  @override
  Future<List<OrderModel>> findAllOrders(
    DateTime date, [
    OrderStatus? status,
  ]) async {
    try {
      final orderResponse = await _dio.auth().get(
        '/orders',
        queryParameters: {
          'date': date.toIso8601String(),
          if (status != null) 'status': status.acronym
        },
      );
      return orderResponse.data.map<OrderModel>((o) => OrderModel.fromMap(o)).toList();
    } on DioError catch (e, s) {
      log(
        'Erro ao Buscar pedidos',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao Buscar pedidos',
      );
    }
  }

  @override
  Future<OrderModel> getById(int id) async {
    try {
      final orderResponse = await _dio.auth().get(
            '/orders/$id',
          );
      return OrderModel.fromMap(orderResponse.data);
    } on DioError catch (e, s) {
      log(
        'Erro ao Buscar pedido',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao Buscar pedido',
      );
    }
  }
}
