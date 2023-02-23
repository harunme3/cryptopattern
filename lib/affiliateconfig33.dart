import 'package:crypto/api33.dart';

class AffiliateConfig33 {
  static getreferraldata(String address) async {
    Map<String, List<Map<String, Object>>> json = {'edges': []};
    var response = await API33.getdirecrtreferral(address: address);
    if (response["status"] == true) {
      for (var i = 0; i < response['data'].length; i++) {
        json['edges']!.add(
          {
            'from': address,
            'to': response['data'][i].toString(),
          },
        );
      }

      return json;
    } else {
      return json;
    }
  }
}
