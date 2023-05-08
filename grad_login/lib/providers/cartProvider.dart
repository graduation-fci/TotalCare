import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:grad_login/my_config.dart';
import '../infrastructure/shared/storage.dart';
import 'drugProvider.dart';

class CartItem with ChangeNotifier {
  int id;
  String name;
  // String name_ar;
  double price;
  String imgURL;
  int quantity;
  double totalPrice;

  CartItem(
      {required this.id,
      required this.name,
      // required this.name_ar,
      required this.price,
      required this.imgURL,
      required this.quantity,
      required this.totalPrice});
}

class Cart with ChangeNotifier {
  String? errorMSG;

  Storage storage = Storage();
  List<CartItem> _list = [];
  String cartID = '';
  double cartPrice = 0.0;

  List<CartItem> get items {
    return [..._list];
  }

  Future<void> getCartID() async {
    String? token;
    await storage.getToken().then((value) {
      token = value;
    });

    final url = Uri.parse(Config.carts);
    final response = await http.get(url, headers: {
      'Authorization': 'JWT $token',
    });
    final extractedData = json.decode(response.body) as List<dynamic>;
    //log(extractedData.toString());
    final id = extractedData[0]['id'];
    cartID = id;
    final price = extractedData[0]['total_price'];
    cartPrice = price;
    log(cartID);
    log(price.toString());
    notifyListeners();
  }

  Future<void> fetchCart(String id) async {
    final List<CartItem> loadedCat = [];

    String? token;
    await storage.getToken().then((value) {
      token = value;
    });
    final url = Uri.parse('${Config.carts}$id');
    final response = await http.get(url, headers: {
      'Authorization': 'JWT $token',
    });
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      log(extractedData.toString());
      for (var i = 0; i < extractedData['items'].length; i++) {
        // log(extractedData['items'].length.toString());
        loadedCat.add(
          CartItem(
            id: extractedData['items'][i]['id'],
            name: extractedData['items'][i]['product']['name'],
            // name_ar: extractedData['items'][i][''],
            price: extractedData['items'][i]['product']['price'],
            imgURL: extractedData['items'][i]['product']['medicine_images'][0],
            quantity: extractedData['items'][i]['quantity'],
            totalPrice: extractedData['items'][i]['total_price'],
          ),
        );
        _list = loadedCat;
      }
      notifyListeners();
    } else {
      errorMSG = 'Failed to load Cart Items!';
    }
  }

  Future<void> addCart(String id, int drugID, int num) async {
    String? token;
    await storage.getToken().then((value) {
      token = value;
    });
    final url = Uri.parse('${Config.carts}$id/items/');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "product_id": drugID,
        "quantity": num,
      }),
    );
    log(id.toString());
    log(drugID.toString());
    log(num.toString());
    if (response.statusCode == 201) {
      notifyListeners();
      // log('Added!');
    } else {
      errorMSG = 'Failed to add item to cart. Please try again later!';
      // log(response.statusCode.toString());
      // log('A7A');
    }
  }

  Future<void> updateCart(String id, int drugID, int number) async {
    log('cart ID: $id');
    log('drug ID: ${drugID.toString()}');
    log('new quantity: ${number.toString()}');
    String? token;
    await storage.getToken().then((value) {
      token = value;
    });
    final url = Uri.parse('${Config.carts}$id/items/$drugID/');
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          "quantity": number,
        },
      ),
    );
    log(url.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('Updated');
      // _list[addressIndex] = addressItem;
    } else {
      log('A7A');
      errorMSG = 'Failed to update address, try again later!';
    }
    fetchCart(id);
    getCartID();
    notifyListeners();
  }

  Future<void> deleteCart(String cartid, int id) async {
    String? token;
    await storage.getToken().then((value) {
      token = value;
    });
    final addressIndex = _list.indexWhere((element) => element.id == id);
    final url = Uri.parse('${Config.carts}$cartID/items/$id/');
    log(_list.toString());
    log(url.toString());
    CartItem? existingProduct = _list[addressIndex];
    _list.removeAt(addressIndex);
    notifyListeners();
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode >= 400) {
      _list.insert(addressIndex, existingProduct);
      notifyListeners();
      errorMSG = 'Failed to delete item, try again later!';
    }
    log('Deleted !');
    existingProduct = null;
  }
}