import 'package:flutter/material.dart';
import 'package:sql_demo/helpers/db_helper.dart';

import '../modals/hotel_modal.dart';

class DbController extends ChangeNotifier {
  List<Hotel> allHotels = [];

  DbController() {
    init();
  }

  Future<void> init() async {
    allHotels = await DbHelper.dbHelper.getRecords();
    notifyListeners();
  }

  insert({required Hotel hotel}) async {
    await DbHelper.dbHelper.insertRecord(hotel: hotel).then((value) => init());
    notifyListeners();
  }

  update({required Hotel hotel}) async {
    await DbHelper.dbHelper.updateRecord(hotel: hotel).then((value) => init());
    notifyListeners();
  }

  delete({required Hotel hotel}) async {
    await DbHelper.dbHelper.deleteRecord(id: hotel.id).then((value) => init());
    notifyListeners();
  }
}
