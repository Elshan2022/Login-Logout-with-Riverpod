import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learning/future_provider_example/model/login_request_model.dart';
import 'package:flutter_riverpod_learning/future_provider_example/model/login_response_model.dart';
import 'package:dio/dio.dart';

final dioInstanceProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
      baseUrl: "https://reqres.in",
      headers: {"Content-Type": "application/json"}));
});

final loginProvider =
    FutureProvider.family<LoginResponseModel?, LoginRequestModel>(
  (ref, model) async {
    try {
      final dio = ref.watch(dioInstanceProvider);
      final response = await dio.post("/api/login", data: model);
      if (response.statusCode == HttpStatus.ok) {
        final body = response.data;
        final loginResponse = LoginResponseModel.fromJson(body);
        return loginResponse;
      } else {
        throw DioException(
          error: "Api Error",
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(),
        );
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  },
);
