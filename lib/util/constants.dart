/*String ph = "https://restapi.spotima.id";
String domain = "restapi.spotima.id";
String ph_socket = "https://restapi.spotima.id";*/

// Production

/*
String ph = "https://www.spotima.id";
String domain = "www.spotima.id";
String ph_socket = "https://www.spotima.id";
*/

// Development

/*String ph = "https://webdev.spotima.id";
String domain = "webdev.spotima.id";
String ph_socket = "https://webdev.spotima.id";*/

// local dev
String ph = "http://localhost:8989";
String domain = "localhost:8989";
String ph_socket = "http://localhost:8989";
// String ph = "http://192.168.100.139:8989";
// String domain = "192.168.100.139:8989";
// String ph_socket = "http://192.168.100.139:8989";

// local dev with json-server

const String baseUrl = 'http://localhost:3000'; // for web or desktop
//const String baseUrl = 'http://10.0.2.2:3000'; // for avd or mobile

enum SppaStatusCode {
  Baru,
  Submit1,
  Tolak1,
  Submit2,
  Tolak2,
  Submit3,
  Downloaded,
  Polis,
  Tolak3
}
