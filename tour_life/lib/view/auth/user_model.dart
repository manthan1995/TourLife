class ApiResponseModel<T> {
  late bool? error;
  late String? message;
  late T? data;

  ApiResponseModel({
    this.data,
    this.message,
    this.error,
  });

  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }
}
