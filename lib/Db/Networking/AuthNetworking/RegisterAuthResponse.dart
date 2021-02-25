class RegisterApiResponse<T> {
  Status status;
  T data;
  String message;

  RegisterApiResponse.authenticating(this.message)
      : status = Status.REGISTERING;

  RegisterApiResponse.completed(this.message) : status = Status.COMPLETED;

  RegisterApiResponse.error(this.message) : status = Status.ERROR;
}
enum Status { REGISTERING, COMPLETED, ERROR }
