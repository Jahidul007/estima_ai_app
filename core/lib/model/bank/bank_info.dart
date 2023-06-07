class BankInfo {
  String? accountNumber;
  String? bankId;
  String? bankName;
  String? branchId;
  String? branchName;
  String? id;

  BankInfo(
      {this.accountNumber,
      this.bankId,
      this.bankName,
      this.branchId,
      this.branchName,
      this.id});

  factory BankInfo.fromJson(Map<String, dynamic> json) {
    return BankInfo(
      accountNumber: json['accountNumber'],
      bankId: json['bankId'],
      bankName: json['bankName'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountNumber'] = this.accountNumber;
    data['bankId'] = this.bankId;
    data['bankName'] = this.bankName;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toUpdateCustomerRequestJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountNumber'] = this.accountNumber;
    data['bankId'] = this.bankId;
    data['branchId'] = this.branchId;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toAddBankRequestJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountNumber'] = this.accountNumber;
    data['bankId'] = this.bankId;
    data['bankName'] = this.bankName;
    data['branchId'] = this.branchId;
    data['branchName'] = this.branchName;
    return data;
  }

  String getBankNameWithAccount() {
    String text = "";

    text = ((bankName == null || bankName!.trim().isEmpty) ? "" : bankName)!;
    text += (text.length >= 1) ? " " : "";
    text += accountNumber == null ? "" : "($accountNumber)";

    return text;
  }
}
