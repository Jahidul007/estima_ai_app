import 'package:core/model/paging/sort.dart';

class Pageable {
  int? page;
  int? size;
  Sort? sort;

  Pageable({this.page, this.size, this.sort});

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      page: json['page'],
      size: json['size'],
      sort: json['sort'] != null && json['sort'] is Map<String, dynamic>
          ? Sort.fromJson(json['sort'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    data['sort'] = this.sort;
    return data;
  }
}
