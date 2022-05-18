class UserModel{
 String? uid;
 String? email;
 String? firstname;
 String? lastname;
 String? phone;
 String? address;
 UserModel({this.uid,this.email,this.firstname,this.lastname,this.phone,this.address});
 factory UserModel.fromMap(map){
   return UserModel(
     uid: map['uid'],
     email: map['email'],
     firstname: map['firstname'],
     lastname: map['lastname'],
     phone: map['phone'],
     address: map['address'],
   );

 }
 Map<String,dynamic> toMap(){
   return {
     'uid' : uid,
     'email' : email,
     'firstname': firstname,
     'lastname': lastname,
     'phone': phone,
     'address': address,
   };
 }
}