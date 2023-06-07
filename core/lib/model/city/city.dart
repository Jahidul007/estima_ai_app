import 'dart:convert';

import 'package:core/model/city/country.dart';
import 'package:core/model/city/states.dart';

class City {
    String? id;
    String? name;
    States? state;
    Country? country;

    City({this.id, this.name, this.state, this.country});

    City.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        name = json['name'];
        state = json['state'] != null ?  States.fromJson(json['state']) : null;
        country =
        json['country'] != null ?  Country.fromJsonMap(json['country']) : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['id'] = id;
        data['name'] = name;
        if (state != null) {
            data['state'] = state!.toJson();
        }
        if (country != null) {
            data['country'] = country!.toJson();
        }
        return data;
    }
}

