class WeatherHTTP {
  // final int statusCode;
  final String city_name;
  final String state_code;
  final String country_code;
  final String timezone;
  final double lat;
  final double lon;

  WeatherHTTP({
    required this.city_name,
    required this.state_code,
    required this.country_code,
    required this.timezone,
    required this.lat,
    required this.lon,
  });

  factory WeatherHTTP.fromJson(Map<String, dynamic> json) {
    return WeatherHTTP(
      city_name: json['city_name'],
      state_code: json['state_code'],
      country_code: json['country_code'],
      timezone: json['timezone'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}
