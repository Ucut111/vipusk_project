class Product {
  String name;
  int id;
  int target_fg;
  String image_url;

  Product(this.name, this.id, this.target_fg, this.image_url);
  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      json['name'],
      json['id'],
      json['target_fg'], //.cast<double>(),
      json['image_url'],
    );
  }
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image_url = json['image_url'];
  }
}
