import 'package:http/http.dart' as http;
import 'package:http/http.dart';

int page;
Future<Response> getListBeerFromApi(page) async {
  dynamic url = 'https://api.punkapi.com/v2/beers?page=$page&per_page=10';

  return await http.get(url);
}

Future<Response> getRandomBeerFromApi() async {
  const url = 'https://api.punkapi.com/v2/beers/random';

  return await http.get(url);
}
