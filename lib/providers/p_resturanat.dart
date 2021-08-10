import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hostel_app/models/getItems.dart';
import 'package:hostel_app/models/getRestuarant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class P_Restuarant with ChangeNotifier {
  List<GetRestuarant> items = [];
  List<GetItems> itemss = [];
  List<GetRestuarant> searchitem = [];
  List<GetItems> searchitems = [];
  Future<void> fetchrestuarant() async {
    print("fetchshops");
    try {
      final List<GetRestuarant> loadedshop = [];
      final response = await http.get(
        Uri.parse('http://9c4395f19f3d.ngrok.io/get_restaurants'),
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
        Uri.parse('http://9c4395f19f3d.ngrok.io/get_items/$id'),
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

  bool searchfromitems(String search) {
    print("serachfromitems");
    searchitems = [];
    if (items != null) {
      List<GetItems> searchlist = itemss
          .where((element) =>
              element.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
      if (searchlist != null) {
        searchlist.forEach((element) {
          print("element is ");
          print(element);
          final tempp = searchitem.firstWhere(
            (f) => f.id == element.id,
          );
          if (tempp == null) {
            searchitems.add(element);
            print("it is added");
          }
        });
        notifyListeners();
        return true;
      }
      return false;
    }
    print("serachfromitems last");
    return false;
  }

  late String temp;
  Future<void> searchShop(String search) async {
    try {
      final response = await http.get(
        Uri.parse('http://9c4395f19f3d.ngrok.io/get_restaurant_byname/$search'),
      );
      final res = json.decode(response.body);
      final List<GetRestuarant> loadedshop = [];
      print("res of serachshop is $res");
      res.forEach((f) {
        loadedshop.add(
          GetRestuarant(
            id: f['id'],
            phone: f['phone'],
            address: f['address'],
            o_name: f['Owner_name'],
            loggedin_with: f['loggedin_with'],
            r_name: f['Restaurant_name'],
          ),
        );
      });
      print(loadedshop);
      loadedshop.forEach((element) {
        print("element is ");
        print(element);
        searchitem.add(element);
        print("it is added");
      });
      // int i = 0;
      // loadedshop.forEach((element) {
      //   print("element is ");
      //   print(element);
      //   final tempp = findshopbyid()
      //       .firstWhere((f) => f.id == element.id, orElse: () => null);
      //   if (tempp == null) {
      //     findshopbyid(st_id).add(element);
      //     i++;
      //     print("it is added");
      //   }
      // });
      // if (i == 0) {
      //   searchShop(search, flag);
      // }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
