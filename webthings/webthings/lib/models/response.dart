
import 'package:webthings/services/locator.dart';
import 'package:webthings/services/local_storage.dart';
var storageService = locator.get<LocalStorageService>();

class IP {
  final String ip;

	IP.fromJsonMap(Map<String, dynamic> map):
		ip = map["ip"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ip'] = ip;
		return data;
	}


}
