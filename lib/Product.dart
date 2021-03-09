class Beer {
  String name;
  int id;
  // String abv;
  // String ibu;
  // String ph;
  String image_url;
  String tagline;

  Beer(
      this.name,
      this.id,
      // this.abv, this.ibu, this.ph,
      this.image_url,
      this.tagline);
  factory Beer.fromMap(Map<String, dynamic> json) {
    return Beer(
      json['name'],
      json['id'],
      // json['abv'],
      // json['ibu'],
      // json['ph'], //.cast<double>(),
      json['image_url'],
      json['tagline'],
    );
  }
  Beer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image_url = json['image_url'];
    // abv = json['abv'];
    // ibu = json['ibu'];
    // ph = json['ph'];
    tagline = json['tagline'];
  }
}
