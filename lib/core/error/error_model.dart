class ErrorModel {
  bool? success;
  String? message;

  ErrorModel({this.success, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
