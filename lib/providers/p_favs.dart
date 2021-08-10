import 'package:flutter/cupertino.dart';
import 'package:hostel_app/models/favsShop.dart';
import 'package:hostel_app/models/FavItems.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class P_Favs with ChangeNotifier {
  final url = "http://d221c891af5c.ngrok.io";
  List<FavShop> items = [];
  List<FavItems> itemss = [];
  List<FavShop> searchitem = [];
  List<FavItems> searchitems = [];

  Future<void> fetchFavShop() async {
    print("fetchshops");
    try {
      final List<FavShop> loadedshop = [];
      final response = await http.get(
        Uri.parse('$url/get_fav_restaurant'),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(response.body);
      print('res');
      print(res);
      res.forEach(
        (f) => loadedshop.add(
          FavShop(
            id: f['id'],
            phone: f['phone'],
            address: f['address'],
            o_name: f['Owner_name'],
            loggedin_with: f['loggedin_with'],
            r_name: f['Restaurant_name'],
            category: f['Category'],
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

  FavShop findByIdFavShop(int id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchFavItems() async {
    print("fetchitems");
    try {
      final List<FavItems> loadedshop = [];
      final response = await http.get(
        Uri.parse('$url/get_fav_items'),
        headers: {
          "Content-Type": "application/json",
          //'Authorization': ,
        },
      );
      final res = json.decode(response.body);
      print('res');
      print(res);
      res.forEach(
        (f) => loadedshop.add(
          FavItems(
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

  FavItems findByIdItems(int id) {
    return itemss.firstWhere((element) => element.id == id);
  }
}
