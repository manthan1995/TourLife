class LoginModel {
  int? status;
  bool? error;
  String? message;
  Result? result;

  LoginModel({this.status, this.error, this.message, this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  int? id;
  String? firstName;
  String? lastName;
  String? token;
  bool? isManager;

  Result({this.id, this.firstName, this.lastName, this.token, this.isManager});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    token = json['token'];
    isManager = json['is_manager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['token'] = token;
    data['is_manager'] = isManager;
    return data;
  }
}
