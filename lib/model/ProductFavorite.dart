class BeerFav {
  String name;
  int id;
  // String abv;
  // String ibu;
  // String ph;
  String image_url;
  String tagline;

  BeerFav(
      {this.name,
      this.id,
      // this.abv, this.ibu, this.ph,
      this.image_url,
      this.tagline});
}

class FavState {
  Map<String, BeerFav> _favItems = {};

  void addBeer({id, name, image_url, tagline}) {
    _favItems.putIfAbsent(
        id,
        () => BeerFav(
            id: id, name: name, image_url: image_url, tagline: tagline));
  }

  void deletBeer(id) {
    _favItems.remove(id);
  }
}
