import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/favDogModel.dart';
import '../repositories/FavoriteDogRepository.dart';

class FavoriteDogViewModel with ChangeNotifier {
  FavoriteDogRepository _favoriteDogRepository = FavoriteDogRepository();
  Stream<QuerySnapshot<FavoriteDogModel>>? _favdog;
  Stream<QuerySnapshot<FavoriteDogModel>>? get favdog => _favdog;

  Future<void> getDog() async {
    var response = await _favoriteDogRepository.getDog(); // Ensure it's awaited
    _favdog = response;

    // Instead of notifying listeners here, trigger it in a post-frame callback
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> deleteDog(String id) async {
    await _favoriteDogRepository.deleteDog(id);

    // Notify listeners after the operation is complete
    notifyListeners();
  }
}
