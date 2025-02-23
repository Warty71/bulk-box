import 'package:dio/dio.dart';

class YGOProApiDatasource {
  final Dio _dio;
  static const String baseUrl = 'https://db.ygoprodeck.com/api/v7';

  YGOProApiDatasource()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ));

  Future<Map<String, dynamic>> searchCards(String query) async {
    final response = await _dio.get('/cardinfo.php', queryParameters: {
      'fname': query,
    });
    return response.data;
  }

  Future<List<int>> getCardImage(int cardId) async {
    final response = await _dio.get(
      '/cardinfo.php',
      queryParameters: {'id': cardId},
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data;
  }
}
