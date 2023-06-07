class Contract {
  String? balanceMode;
  String? companyId;
  String? contractCode;
  int? contractDuration;
  String? currency;
  String? currentAccountMode;
  String? customerCode;
  String? description;
  String? id;
  bool? isValidateFuelRequired;
  bool? isValidateSiteRequired;
  String? paymentMode;
  String? startDate;
  String? status;

  Contract(
      {this.balanceMode,
      this.companyId,
      this.contractCode,
      this.contractDuration,
      this.currency,
      this.currentAccountMode,
      this.customerCode,
      this.description,
      this.id,
      this.isValidateFuelRequired,
      this.isValidateSiteRequired,
      this.paymentMode,
      this.startDate,
      this.status});

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      balanceMode: json['balanceMode'],
      companyId: json['companyId'],
      contractCode: json['contractCode'],
      contractDuration: json['contractDuration'],
      currency: json['currency'],
      currentAccountMode: json['currentAccountMode'],
      customerCode: json['customerCode'],
      description: json['description'],
      id: json['id'],
      isValidateFuelRequired: json['isValidateFuelRequired'],
      isValidateSiteRequired: json['isValidateSiteRequired'],
      paymentMode: json['paymentMode'],
      startDate: json['startDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balanceMode'] = this.balanceMode;
    data['companyId'] = this.companyId;
    data['contractCode'] = this.contractCode;
    data['contractDuration'] = this.contractDuration;
    data['currency'] = this.currency;
    data['currentAccountMode'] = this.currentAccountMode;
    data['customerCode'] = this.customerCode;
    data['description'] = this.description;
    data['id'] = this.id;
    data['isValidateFuelRequired'] = this.isValidateFuelRequired;
    data['isValidateSiteRequired'] = this.isValidateSiteRequired;
    data['paymentMode'] = this.paymentMode;
    data['startDate'] = this.startDate;
    data['status'] = this.status;
    return data;
  }
}
