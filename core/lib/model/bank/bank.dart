class Bank {
  String? aba;
  bool? active;
  String? code;
  String? id;
  String? name;

  Bank({this.aba, this.active, this.code, this.id, this.name});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      aba: json['aba'],
      active: json['active'],
      code: json['code'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aba'] = this.aba;
    data['active'] = this.active;
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
