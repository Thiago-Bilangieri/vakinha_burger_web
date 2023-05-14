// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/payment_type_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';

part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  initial,
  loading,
  loaded,
  addOrUpdatePayment,
  error,
  saved,
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepository _paymentTypeRepository;

  @readonly
  var _status = PaymentTypeStateStatus.initial;

  @readonly
  var _paymentTypes = <PaymentTypeModel>[];

  @readonly
  String? _errorMessage;

  @readonly
  bool? _filterEnabled;

  @readonly
  PaymentTypeModel? _paymentTypeModel;

  PaymentTypeControllerBase(this._paymentTypeRepository);

  void changeFilter(bool? enabled) {
    _filterEnabled = enabled;
  }

  @action
  Future<void> loadPayment() async {
    try {
      _status = PaymentTypeStateStatus.loading;
      _paymentTypes = await _paymentTypeRepository.findAll(_filterEnabled);
      _status = PaymentTypeStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar formas de pagamento!!', error: e, stackTrace: s);
      _status = PaymentTypeStateStatus.error;
      _errorMessage = 'Erro ao carregar formas de pagamento!';
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentTypeStateStatus.loaded;
    await Future.delayed(Duration.zero);
    _paymentTypeModel = null;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> editPayment(PaymentTypeModel paymentTypeModel) async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeModel = paymentTypeModel;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    int? id,
    required String name,
    required String acronym,
    required bool enabled,
  }) async {
    _status = PaymentTypeStateStatus.loading;
    await _paymentTypeRepository.save(PaymentTypeModel(
        id: id, name: name, acronym: acronym, enabled: enabled,),);
    _status = PaymentTypeStateStatus.saved;
  }
}
