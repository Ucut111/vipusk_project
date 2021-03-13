import 'package:vipusk_project/model/Product.dart';

import 'getting_list_interactor.dart';

class Repository {
  Future<List<Beer>> loadListBeers() async =>
      await GettingBeerListInteractor().execute();
}
