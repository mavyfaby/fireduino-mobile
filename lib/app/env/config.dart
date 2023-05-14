const String appName = "Fireduino";
const String appTagline = "Fire safety made easy with Fireduino";
const String appDefaultFont = "Poppins";

const bool isDebugMode = false;
const String webServerApi = isDebugMode ? "http://192.168.1.145:4000/mobile" : "https://fireduino.azurewebsites.net/mobile";
const String socketServerApi = isDebugMode ? "http://192.168.1.145:5000" : "https://fireduino-ws.azurewebsites.net";

const double defaultLatitude = 10.3157;
const double defaultLongitude = 123.8854;