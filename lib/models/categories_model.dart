class CategoriesModel {
int? id;
String? name;
String? slugname;
String? image_url;
int? parentid;
bool? isactive;
int? display_order;

CategoriesModel({
  this.id,
  this.name,
  this.slugname,
  this.image_url,
  this.parentid,
  this.isactive,
  this.display_order,
});

CategoriesModel.fromJson(Map<String,dynamic>json){
id=json['id'];
name=json['name'];
slugname=json['slugname'];
image_url=json['image_url'];
parentid=json['parentid'];
isactive=json['isactive'];
display_order=json['display_order'];
}
Map<String,dynamic> toJson(){
final Map<String,dynamic> data=new Map<String,dynamic>();
data['id']=this.id;
data['name']=this.name;
data['slugname']=this.slugname;
data['image_url']=this.image_url;
data['parentid']=this.parentid;
data['isactive']=this.isactive;
data['display_order']=this.display_order;
return data;
}
}