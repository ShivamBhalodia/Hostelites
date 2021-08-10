import 'package:flutter/cupertino.dart';
import 'package:hostel_app/models/getRestuarant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class P_Restuarant with ChangeNotifier {
  List<GetRestuarant> items = [];
  Future<void> fetchrestuarant() async {
    print("fetchshops");
    try {
      final List<GetRestuarant> loadedshop = [];
      final response = await http.get(
        Uri.parse('http://5fad36087463.ngrok.io/get_restaurants'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(response.body);
      print('res');
      print(res);
      res.forEach(
        (f) => loadedshop.add(
          GetRestuarant(
            id: f['id'],
            phone: f['phone'],
            address: f['address'],
            o_name: f['Owner_name'],
            loggedin_with: f['loggedin_with'],
            r_name: f['Restaurant_name'],
          ),
        ),
      );
      items = loadedshop;
      print(items);
      print(res);
    } catch (error) {
      throw (error);
    }
  }

  GetRestuarant findByIdShop(int id) {
    return items.firstWhere((element) => element.id == id);
  }
}
