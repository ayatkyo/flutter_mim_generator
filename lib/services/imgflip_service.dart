import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imgflipApiProvider = Provider<Dio>((ref) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.imgflip.com",
    ),
  );

  return dio;
});
