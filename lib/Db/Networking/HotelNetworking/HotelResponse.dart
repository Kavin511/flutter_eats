class HotelApiResponse<T> {
  Status status;
  T data;
  String message;

  HotelApiResponse.loading(this.message) : status = Status.LOADING;

  HotelApiResponse.completed(this.data) : status = Status.COMPLETED;

  HotelApiResponse.error(this.message) : status = Status.ERROR;
}
enum Status {
  LOADING,
  COMPLETED,
  ERROR
}