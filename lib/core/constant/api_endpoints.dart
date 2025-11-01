class ApiEndpoints {
  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String apiKey = 'd7d4876a34ea0c4687d0e36a8feff39e';
  static const String language = 'en-US';
  static const String nowPlaying= 'movie/now_playing';

  static String getEndpoint(String endpoint) {
    return '$baseUrl$endpoint?api_key=$apiKey&language=$language';
  }
}

extension XImageUrl on String {
  String get toImageUrl => 'https://image.tmdb.org/t/p/w500$this';
}
