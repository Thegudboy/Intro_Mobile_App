import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/AdoptModel.dart';
import '../repositories/adopt_repo.dart';

class AdoptionViewModel with ChangeNotifier {
  AdoptionRepo _adoptionRepo = AdoptionRepo();
  Stream<QuerySnapshot<AdoptionModel>>? _adoptdog;
  Stream<QuerySnapshot<AdoptionModel>>? get adoptDog => _adoptdog;

  Future<void> getAdopt() async {
    var response = await _adoptionRepo.getAdopts(); // Ensure it's awaited
    _adoptdog = response;

    // Instead of notifying listeners here, trigger it in a post-frame callback
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> deleteAdopt(String id) async {
    await _adoptionRepo.deleteAdopt(id);

    // Notify listeners after the operation is complete
    notifyListeners();
  }
}
