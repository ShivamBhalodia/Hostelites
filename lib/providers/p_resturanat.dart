import 'package:flutter/cupertino.dart';
import 'package:hostel_app/models/getItems.dart';
import 'package:hostel_app/models/getRestuarant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class P_Restuarant with ChangeNotifier {
  List<GetRestuarant> items = [];
  List<GetItems> itemss = [];
  Future<void> fetchrestuarant() async {
    print("fetchshops");
    try {
      final List<GetRestuarant> loadedshop = [];
      final response = await http.get(
        Uri.parse('http://3d6997c9a037.ngrok.io/get_restaurants'),
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

  Future<void> fetchItems(int id) async {
    print("fetchitems");
    try {
      final List<GetItems> loadedshop = [];
      final response = await http.get(
        Uri.parse('http://3d6997c9a037.ngrok.io/get_items/$id'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(response.body);
      print('res');
      print(res);
      res.forEach(
        (f) => loadedshop.add(
          GetItems(
            id: f['id'],
            name: f['Name'],
            description: f['Description'],
            price: f['Price'],
            category: f['Category'],
          ),
        ),
      );
      itemss = loadedshop;
      print(itemss);
      print(res);
    } catch (error) {
      throw (error);
    }
  }

  GetItems findByIdItems(int id) {
    return itemss.firstWhere((element) => element.id == id);
  }
}
