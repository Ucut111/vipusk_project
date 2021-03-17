import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> getListBeerFromApi() async {
  const url = 'https://api.punkapi.com/v2/beers?page=2&per_page=80';

  return await http.get(url);
}

Future<Response> getRandomBeerFromApi() async {
  const url = 'https://api.punkapi.com/v2/beers/random';

  return await http.get(url);
}
