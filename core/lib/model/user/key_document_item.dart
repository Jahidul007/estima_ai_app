class UserKycDocuments {
  String? fileName;
  String? filePath;
  String? id;
  String? type;

  UserKycDocuments({this.fileName, this.filePath, this.id, this.type});

  UserKycDocuments.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    filePath = json['filePath'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['fileName'] = fileName;
    data['filePath'] = filePath;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}