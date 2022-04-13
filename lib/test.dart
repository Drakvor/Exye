import 'package:dio/dio.dart';

void main () async {
  var res = await Dio().post("https://oapicc.ecount.com/OAPI/V2/OAPILogin", data: {
    "COM_CODE": 620471,
    "USER_ID": "Admin",
    "API_CERT_KEY": "",
    "LAN_TYPE": "ko_KR",
    "ZONE": "cc",
  });
  print(res.data["Data"]["Datas"]["SESSION_ID"]);
}