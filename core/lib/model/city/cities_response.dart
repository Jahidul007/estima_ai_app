import 'package:core/model/paging/pageable.dart';
import 'package:core/model/paging/sort.dart';
import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';
import 'package:core/model/city/city.dart';

class CitiesResponse extends BaseResponse{
    List<City>? content;
    bool? empty;
    bool? first;
    bool? last;
    int? number;
    int? numberOfElements;
    Pageable? pageable;
    int? size;
    Sort? sort;
    int? totalElements;
    int? totalPages;

    CitiesResponse({this.content, this.empty, this.first, this.last, this.number, this.numberOfElements, this.pageable, this.size, this.sort, this.totalElements, this.totalPages});

    factory CitiesResponse.fromJson(Map<String, dynamic> json) {
        return CitiesResponse(
            content: json['content'] != null ? (json['content'] as List).map((i) => City.fromJson(i)).toList() : null,
            empty: json['empty'], 
            first: json['first'], 
            last: json['last'], 
            number: json['number'], 
            numberOfElements: json['numberOfElements'], 
            pageable: json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null, 
            size: json['size'], 
            // sort: json['sort'] != null ? Sort.fromJson(json['sort']) : null,
            totalElements: json['totalElements'], 
            totalPages: json['totalPages'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['empty'] = empty;
        data['first'] = first;
        data['last'] = last;
        data['number'] = number;
        data['numberOfElements'] = numberOfElements;
        data['size'] = size;
        data['totalElements'] = totalElements;
        data['totalPages'] = totalPages;
        if (content != null) {
            data['content'] = content?.map((v) => v.toJson()).toList();
        }
        if (pageable != null) {
            data['pageable'] = pageable?.toJson();
        }
        if (sort != null) {
            data['sort'] = sort?.toJson();
        }
        return data;
    }


    CitiesResponse.responseWithError(String message, DioErrorType? errorType){
      isSuccess = false;
      msg = message;
      errorType = errorType;
      content = null;
    }
}