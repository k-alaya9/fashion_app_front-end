class User{
  String? username;
  String? email;
  User(this.username,this.email);
  User.fromJson(json){
    username=json['username'];
    email=json['email'];
  }
  toJson(){
    return {
      'username':username!,
      'email':email!
      };
  }
}