  // {
  //   "id": 1,
  //   "name": "skirt 123",
  //   "description": "a maxi white skirt",
  //   "image_url": "/media/media/image/download_1_CPHwadW.jpeg",
  //   "category": 3
  //    "saved_id":0
  // },

  class clothes{
    int? id;
    String? name;
    String? description;
    String? image_url;
    int? category;
    int? saved_id;
    clothes(this.id,this.name,this.description,this.image_url,this.category);
    clothes.fromJson(json){
       id=json['id'];
       name=json['name'];
       description=json['description']; 
       image_url=json['image_url']; 
       category=json['category'];
       saved_id=json['saved_id'];
    }
  }