class States {
    String? country;
    String? countryId;
    String? id;
    String? name;

    States({this.country, this.countryId, this.id, this.name});

    States.fromJson(Map<String, dynamic> json) {
        country = json['country'];
        countryId = json['countryId'];
        id = json['id'];
        name = json['name'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data =  <String, dynamic>{};
        data['country'] = country;
        data['countryId'] = countryId;
        data['id'] = id;
        data['name'] = name;
        return data;
    }
}