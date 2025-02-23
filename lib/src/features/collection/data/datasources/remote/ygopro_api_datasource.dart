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
    print('🌐 API: Searching cards with query: "$query"');

    final Map<String, dynamic> params = {};
    if (query.isNotEmpty) {
      if (query.contains('=')) {
        // Advanced search parameters
        final queryParts = query.split('&');
        for (final part in queryParts) {
          final keyValue = part.split('=');
          if (keyValue.length == 2) {
            params[keyValue[0].trim()] = keyValue[1].trim();
          }
        }
      } else {
        // Simple name search - use fname for fuzzy search
        params['fname'] = query;
      }
    }

    try {
      final response = await _dio.get(
        '/cardinfo.php',
        queryParameters: params,
      );
      print('🌐 API: Response data structure: ${response.data.runtimeType}');
      print('🌐 API: Response keys: ${response.data.keys}');
      return response.data;
    } catch (e) {
      print('🌐 API: Error during request: $e');
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // Handle "no cards found" case
          return {'data': []};
        }
        print('🌐 API: Error response: ${e.response?.data}');
      }
      rethrow;
    }
  }

  Future<List<int>> getCardImage(int cardId) async {
    print('🌐 API: Fetching image for card: $cardId');
    final response = await _dio.get(
      '/cardinfo.php',
      queryParameters: {'id': cardId},
      options: Options(responseType: ResponseType.bytes),
    );
    print('🌐 API: Received image data');
    return response.data;
  }
}
