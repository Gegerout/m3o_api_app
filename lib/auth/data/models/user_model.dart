class UserModel {
  final String id;
  final String created;
  final String expires;
  final String userId;

   factory UserModel.fromJson(Map<String, dynamic> json) {
       return UserModel(json["id"], json["created"], json["expires"], json["userId"]);
   }

  UserModel(this.id, this.created, this.expires, this.userId);

   Map<String, dynamic> toJson() => {
     "id": id,
     "created": created,
     "expires": expires,
     "userId": userId
   };
}