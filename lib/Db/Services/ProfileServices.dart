import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileSerivces{
  userData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String yourToken = prefs.getString('token');
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    print(yourToken);
    return yourToken;
  }
}