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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
