import 'package:core/model/paging/pageable.dart';
import 'package:core/model/paging/sort.dart';
import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';


import 'bank.dart';

class AllBankResponse extends BaseResponse {
  List<Bank>? content;
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

  AllBankResponse(
      {this.content,
      this.empty,
      this.first,
      this.last,
      this.number,
      this.numberOfElements,
      this.pageable,
      this.size,
      this.sort,
      this.totalElements,
      this.totalPages});

  factory AllBankResponse.fromJson(Map<String, dynamic> json) {
    return AllBankResponse(
      content: json['content'] != null
          ? (json['content'] as List).map((i) => Bank.fromJson(i)).toList()
          : null,
      empty: json['empty'],
      first: json['first'],
      last: json['last'],
      number: json['number'],
      numberOfElements: json['numberOfElements'],
      pageable:
          json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null,
      size: json['size'],
      //sort: json['sort'] != null ? Sort.fromJson(json['sort']) : null,
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    data['first'] = this.first;
    data['last'] = this.last;
    data['number'] = this.number;
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    if (this.content != null) {
      data['content'] = this.content?.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable?.toJson();
    }
    if (this.sort != null) {
      data['sort'] = this.sort?.toJson();
    }
    return data;
  }

  AllBankResponse.responseWithError(String message, DioErrorType? errorType) {
    isSuccess = false;
    msg = message;
    errorType = errorType;
    content = null;
  }
}
