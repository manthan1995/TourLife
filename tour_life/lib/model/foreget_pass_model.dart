class ForgetPassModel {
  int? status;
  bool? error;
  String? message;
  Results? results;

  ForgetPassModel({this.status, this.error, this.message, this.results});

  ForgetPassModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    error = json['error'];
    message = json['message'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['error'] = error;
    data['message'] = message;
    if (results != null) {
      data['results'] = results!.toJson();
    }
    return data;
  }
}

class Results {
  String? email;
  int? otp;

  Results({this.email, this.otp});

  Results.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }
}
