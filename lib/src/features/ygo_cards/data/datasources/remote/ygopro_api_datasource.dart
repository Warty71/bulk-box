import 'package:dio/dio.dart';

class YGOProApiDatasource {
  final Dio _dio;
  static const String baseUrl = 'https://db.ygoprodeck.com/api/v7';

  YGOProApiDatasource()
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );

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

  Future<List<int>> getCardImage(int cardId) async {
    try {
      // First get the card info to get the actual image URL
      final response = await _dio.get(
        '/cardinfo.php',
        queryParameters: {'id': cardId, 'tcgplayer_data': 'yes'},
      );

      final cardData = response.data['data'][0];
      final imageUrl = cardData['card_images'][0]['image_url'];

      // Create a new Dio instance specifically for image download
      final imageDio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.bytes,
      ));

      final imageResponse = await imageDio.get(imageUrl);

      if (imageResponse.statusCode == 200 && imageResponse.data != null) {
        final bytes = imageResponse.data as List<int>;
        return bytes;
      } else {
        throw Exception(
            'Failed to download image: ${imageResponse.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
