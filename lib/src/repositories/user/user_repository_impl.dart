import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/user_model.dart';
import './user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final CustomDio _customDio;

  UserRepositoryImpl(this._customDio);
  @override
  Future<UserModel> getById(int id) async {
    try {
      final userResponse = await _customDio.get('/users/$id');
      return UserModel.fromMap(userResponse.data);
    } on DioError catch (e, s) { 
      log('Erro ao buscar o usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }
}
