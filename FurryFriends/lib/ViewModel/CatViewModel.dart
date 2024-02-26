import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/catModel.dart';
import '../repositories/CatRepository.dart';

class CatViewModel with ChangeNotifier {
  CatRepository _catRepository = CatRepository();
  Stream<QuerySnapshot<CatModel>>? _cat;
  Stream<QuerySnapshot<CatModel>>? get cat => _cat;

  Future<void> getCat() async {
    var response = await _catRepository.getCatData(); // Use await here
    _cat = response;
    notifyListeners();
  }
}
