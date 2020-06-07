class Relative {
  String name, email, phoneNumber, uid, documentID;
  Relative();
  Relative getData(var data) {
    this.phoneNumber = data['phoneNumber'];
    this.email = data['email'];
    this.uid = data['uid'];
    this.name = data['name'];
    this.documentID = data.documentID;
    return this;
  }
}
