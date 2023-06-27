class Data{
  String token;
  String expiretoken;
  String userId;
  String userName;
  String email;
  int userType;
  String mobileNo;
  String profilImage;

  Data(this.token,this.expiretoken,this.userId,this.userName,this.email,this.userType,
      this.mobileNo,this.profilImage);
}
class Authentication{
  Data? data;
  Authentication(this.data);
}

class DeviceInfo{
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name,this.identifier,this.version);
}