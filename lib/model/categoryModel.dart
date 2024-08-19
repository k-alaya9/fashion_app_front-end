class Category{
  int? id;
  String? name;
  String? image_url;
  Category(this.id,this.name,this.image_url);

  Category.fromJson(json){
    id=json['id'];
    name = json['name'];
    image_url = json['image_url'];
  }
}