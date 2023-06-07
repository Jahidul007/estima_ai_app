class KeyPairInfo {
  String? publicKey;
  String? privateKey;
  String? privateKeyId;
  String? signedMessage;

  KeyPairInfo({this.publicKey, this.privateKey, this.privateKeyId, this.signedMessage});

  KeyPairInfo.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
    privateKey = json['privateKey'];
    privateKeyId = json['privateKeyId'];
    signedMessage = json['signedMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publicKey'] = publicKey;
    data['privateKey'] = privateKey;
    data['privateKeyId'] = privateKeyId;
    data['signedMessage'] = signedMessage;
    return data;
  }
}
