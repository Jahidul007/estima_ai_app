class Country {
  String? id;
  String? isoCodeThree;
  String? isoCodeTwo;
  String? name;

  Country({this.id, this.isoCodeThree, this.isoCodeTwo, this.name});

  Country.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    isoCodeThree = json['isoCodeThree'];
    isoCodeTwo = json['isoCodeTwo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['isoCodeThree'] = isoCodeThree;
    data['isoCodeTwo'] = isoCodeTwo;
    data['name'] = name;
    return data;
  }
}
