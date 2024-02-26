import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/favCatModel.dart';
import '../repositories/FavoriteCatRepository.dart';

class FavoriteCatViewModel with ChangeNotifier {
  FavoriteCatRepository _favoriteCatRepository = FavoriteCatRepository();
  Stream<QuerySnapshot<FavoriteCatModel>>? _favcat;
  Stream<QuerySnapshot<FavoriteCatModel>>? get favcat => _favcat;

  Future<void> getCat() async {
    var response = await _favoriteCatRepository.getCat(); // Ensure it's awaited
    _favcat = response;

    // Instead of notifying listeners here, trigger it in a post-frame callback
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> deleteCat(String id) async {
    await _favoriteCatRepository.deleteCat(id);

    // Notify listeners after the operation is complete
    notifyListeners();
  }
}
