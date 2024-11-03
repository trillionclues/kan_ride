class RemoteResponse<T> {
  bool successBool;
  T? data;
  String message;

  RemoteResponse(this.successBool, this.data, this.message);

  static RemoteResponse<T> success<T>(T? data) {
    return RemoteResponse<T>(true, data, "Data fetched successfully!");
  }

  static RemoteResponse<T> defaultValue<T>() {
    return RemoteResponse<T>(false, null, "Default value!");
  }

  static RemoteResponse<T> internetConnectionError<T>() {
    return RemoteResponse<T>(false, null, "Internet connection error!");
  }

  static RemoteResponse<T> somethingWentWrong<T>() {
    return RemoteResponse<T>(false, null, "Something went wrong!");
  }

  static RemoteResponse<T> error<T>(String message) {
    return RemoteResponse<T>(false, null, message);
  }
}