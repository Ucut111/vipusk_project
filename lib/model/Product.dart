class Beer {
  String name;
  int id;
  String abv;
  String ibu;
  String ph;
  String imageUrl;
  String tagline;

  Beer(this.name, this.id, this.abv, this.ibu, this.ph, this.imageUrl,
      this.tagline);
  Beer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    abv = json['abv'].toString();
    ibu = json['ibu'].toString();
    ph = json['ph'].toString();
    tagline = json['tagline'];
  }
}
