import'dart:core';
class Validator{
static String? inputvalidate(String str,String type){
  if(str.isEmpty || str==' '){
    return "Please enter $type";
  }
  else  if(str.length<=1){
    return "Please enter valid $type";
  }
  else{
    return null;
  }
}
static String? phoneValidate(String str){
  str=str.trim();
  if(str.isEmpty || str==' ' ){
    return "please provide valid phone number";
  }
  else if(str.length!=10){
    return "please provide valid phone number";
  }
    return null;
}
static String? emailValidate(String value) {
  value=value.trim();
  if (value.isEmpty) {
    return "Please enter email";
  }
  RegExp reg = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!reg.hasMatch(value)) {
    return "Please enter valid email address";
  }

  return null;
}


static String? passwordValidator(String val,int minlength,int maxlength,) {
  RegExp reg =  RegExp(r'([A-Za-z][0-9])');
  if(val.isEmpty){
    return 'Please Enter Valid Password';
  } else if(val.length<minlength || val.length>maxlength) {
    return 'Password Should be Between $minlength to $maxlength Characters';
  } else if(!reg.hasMatch(val)) {
    return 'Please Enter Valid Password';
  }else {
    return null;
  }
}


}