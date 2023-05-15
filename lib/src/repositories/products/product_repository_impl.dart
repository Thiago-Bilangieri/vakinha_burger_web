import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import 'dart:typed_data';

import './product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final CustomDio _customDio;

  ProductRepositoryImpl(this._customDio);

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await _customDio.auth().put(
        '/products/$id',
        data: {
          'enabled': false,
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar o produto');
    }
  }

  @override
  Future<List<ProductModel>> findAll(String? name) async {
    try {
      final productResult = await _customDio.auth().get(
        '/products',
        queryParameters: {if (name != null) 'name': name, 'enabled': true},
      );
      return productResult.data
          .map<ProductModel>((p) => ProductModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      print('kkkk');
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar os produtos');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final productResult = await _customDio.auth().get(
            '/products/$id',
          );
      return ProductModel.fromMap(productResult.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar o produto $id', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar o produto $id');
    }
  }

  @override
  Future<void> save(ProductModel productModel) async {
    try {
      final client = _customDio.auth();
      final data = productModel.toMap();
      if (productModel.id != null) {
        await client.put('/products/${productModel.id}', data: data);
      } else {
        await client.put('/products', data: data);
      }
    } on DioError catch (e, s) {
      log('Erro ao salvar o produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar o produto');
    }
  }

  @override
  Future<String> uploadImageProduct(Uint8List file, String fileName) async {
    try {
      final formData = FormData.fromMap(
        {'file': MultipartFile.fromBytes(file, filename: fileName)},
      );
      final response = await _customDio.auth().post('/uploads', data: formData);
      return response.data['url'];
    } on DioError catch (e, s) {
      log('Erro ao fazer o upload do arquivo', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao fazer o upload do arquivo');
    }
  }
}
