import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:insurance/model/customer.dart';
import 'package:insurance/util/constants.dart';

class CustomerController extends GetxController {
  Rx<Customer> theCustomer = Customer().obs;
  RxList<Customer> customerList = <Customer>[].obs;
  RxBool isLoaded = false.obs;

  var client = http.Client();

  void getSppaCustomer(String customerId) async {
    var param1 = '?customerId=$customerId';
    isLoaded.value = false;

    print(baseUrl + '/Customer' + param1);
    var url = Uri.parse(baseUrl + '/Customer' + param1);

    http.Response response = await client.get(url); // no authentication needed
    if (response.statusCode == 200) {
      var responseBodySppa = jsonDecode(response.body);
      // print(responseBodySppa);
      for (var i = 0; i < responseBodySppa.length; i++) {
        theCustomer.value = Customer.fromJson(responseBodySppa[i]);
        print('get customer: ${theCustomer.value.fullName}');
        isLoaded.value = true;
      }
    } else {
      print(
          'error get Customer $customerId : ${response.statusCode.toString()}');
    }
  }
}
