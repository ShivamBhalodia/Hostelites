import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class P_Shopkeeper with ChangeNotifier {
  Future<void> registerShopkeeper(
    String phone,
    String password,
    String confirmPassword,
    String name,
    bool isUser,
  ) async {
    final url = 'http://953fa7d8445a.ngrok.io/validatephonesendotp';
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            'shopkeeper': isUser,
            'phone': phone,
            'name': name,
            'password': password,
            'password2': confirmPassword,
          },
        ),
      );
      final res = json.decode(response.body);
      print("jainam in p_shopkeeper");
      print(res);
      if (res['status'] != true) {
        throw HttpException(res['detail']);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> loginshopkeeper(
    String phone,
    String password,
    bool isUser,
  ) async {
    final url = 'https://953fa7d8445a.ngrok.io/login';
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            'shopkeeper': isUser,
            'phone': phone,
            'password': password,
          },
        ),
      );
      final res = json.decode(response.body);
      print("jainam in p_consumer");
      print(res);
      if (res['status'] != true) {
        throw HttpException(res['detail']);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
