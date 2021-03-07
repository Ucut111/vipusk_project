import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> getListBeerFromApi() async {
  const url = 'https://api.punkapi.com/v2/beers/';

  return await http.get(url);
}
