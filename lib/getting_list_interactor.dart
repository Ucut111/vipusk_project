import 'package:http/http.dart';
import 'dart:convert';
import 'api.dart';

import 'model/Product.dart';

int page = 1;

class GettingBeerListInteractor {
  Future<List<Beer>> execute({String query}) async {
    try {
      Response response = await getListBeerFromApi(page);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<Beer> result = data.map((e) => Beer.fromJson(e)).toList();
        page++;
        return result;
      } else {
        print('Error');
      }
    } catch (ex) {
      return null;
    }
    return null;
  }
}

class GettingBeerRandomInteractor {
  Future<List<Beer>> execute({String query}) async {
    try {
      Response response = await getRandomBeerFromApi();
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        List<Beer> result = data.map((e) => Beer.fromJson(e)).toList();
        return result;
      } else {
        print('Error');
      }
    } catch (ex) {
      return null;
    }
    return null;
  }
}
