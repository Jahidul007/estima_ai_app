class Branch {
  String? bankId;
  String? code;
  String? id;
  String? name;

  Branch({this.bankId, this.code, this.id, this.name});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      bankId: json['bankId'],
      code: json['code'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankId'] = this.bankId;
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
