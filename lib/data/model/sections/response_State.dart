class ResponseStatus {
  int? statusCode;
  String? status;
  String? message;

  ResponseStatus({this.statusCode, this.status, this.message});

  ResponseStatus.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
