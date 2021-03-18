class BeerFav {
  String name;
  int id;
  String imageUrl;
  String tagline;

  BeerFav({this.name, this.id, this.imageUrl, this.tagline});
}

class FavState {
  Map<String, BeerFav> _favItems = {};

  void addBeer({id, name, imageUrl, tagline}) {
    _favItems.putIfAbsent(
        id,
        () =>
            BeerFav(id: id, name: name, imageUrl: imageUrl, tagline: tagline));
  }

  void deletBeer(id) {
    _favItems.remove(id);
  }
}
