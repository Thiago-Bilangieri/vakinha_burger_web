// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/payment_type_model.dart';
import './payment_type_repository.dart';

class PaymentTypeRepositoryImpl implements PaymentTypeRepository {
  final CustomDio _customDio;
  PaymentTypeRepositoryImpl(
    this._customDio,
  );

  @override
  Future<List<PaymentTypeModel>> findAll(bool? enabled) async {
    try {
      final paymentResult = await _customDio.auth().get(
        '/payment-types',
        queryParameters: {if (enabled != null) 'enabled': enabled},
      );
      return paymentResult.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamentos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamentos');
    }
  }

  @override
  Future<PaymentTypeModel> getById(int id) async {
    try {
      final paymentResult = await _customDio.auth().get(
            '/payment-types/$id',
          );
      return PaymentTypeModel.fromMap(paymentResult.data);
    } on DioError catch (e, s) {
      log(
        'Erro ao buscar formas de pagamentos por id $id',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao buscar formas de pagamentos por id',
      );
    }
  }

  @override
  Future<void> save(PaymentTypeModel model) async {
    try {
      final client = _customDio.auth();
      if (model.id != null) {
        await client
            .auth()
            .put('/payment-types/${model.id}', data: model.toMap());
      } else {
        await client.auth().post('/payment-types/', data: model.toMap());
      }
    } on DioError catch (e, s) {
      log('Erro ao cadastrar metodo de pagamento', error: e, stackTrace: s);
      throw RepositoryException(
        message: 'Erro ao cadastrar metodo de pagamento',
      );
    }
  }
}
