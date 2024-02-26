import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/dogModel.dart';
import '../repositories/DogRepository.dart';

class DogViewModel with ChangeNotifier {
  DogRepository _dogRepository = DogRepository();
  Stream<QuerySnapshot<DogModel>>? _dog;
  Stream<QuerySnapshot<DogModel>>? get dog => _dog;

  Future<void> getDog() async {
    var response = await _dogRepository.getDogData(); // Use await here
    _dog = response;
    notifyListeners();
  }
}
