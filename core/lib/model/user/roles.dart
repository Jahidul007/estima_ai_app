class Roles {
  String? id;
  String? name;
  int? priority;
  bool? systemDefined;
  String? type;

  Roles({this.id, this.name, this.priority, this.systemDefined, this.type});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priority = json['priority'];
    systemDefined = json['systemDefined'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['priority'] = priority;
    data['systemDefined'] = systemDefined;
    data['type'] = type;
    return data;
  }
}