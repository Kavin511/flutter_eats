class Hotel {
  String mobileNumber;
  String email;
  String address;
  String hotelName;
  Hotel({
    // this.mobileNumber
    this.mobileNumber,
    this.email,
    this.address,
    this.hotelName,
  });
  Hotel.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    address = json['address'];
    hotelName = json['hotelName'];
  }
}
class HotelResponse {
  List<Hotel> hotel;
  HotelResponse({this.hotel});
  HotelResponse.fromJson(Map<String, dynamic> json) {
    print(json['result']);
    if (json['result'] != null) {
      hotel = new List<Hotel>();
      json['result'].forEach((v) {
        hotel.add(Hotel.fromJson(v));
      });
    }
  }
}
