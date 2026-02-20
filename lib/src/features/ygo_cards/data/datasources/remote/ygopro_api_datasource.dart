import 'package:dio/dio.dart';
import 'package:sentry_dio/sentry_dio.dart';

class YGOProApiDatasource {
  final Dio _dio;
  final Dio _imageDio;
  static const String baseUrl = 'https://db.ygoprodeck.com/api/v7';

  YGOProApiDatasource()
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        )..addSentry(),
        _imageDio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            responseType: ResponseType.bytes,
          ),
        )..addSentry();

  Future<Map<String, dynamic>> searchCards(String query) async {
    final Map<String, dynamic> params = {'tcgplayer_data': 'yes'};
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
      return response.data;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // Handle "no cards found" case
          return {'data': []};
        }
      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getCardSets() async {
    try {
      final response = await _dio.get('/cardsets.php');
      final data = response.data;
      if (data is! List) return [];
      return List<Map<String, dynamic>>.from(
        data.map((e) => e is Map<String, dynamic> ? e : <String, dynamic>{}),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> downloadImage(String imageUrl) async {
    final response = await _imageDio.get(imageUrl);

    if (response.statusCode == 200 && response.data != null) {
      return response.data as List<int>;
    } else {
      throw Exception('Failed to download image: ${response.statusCode}');
    }
  }
}
