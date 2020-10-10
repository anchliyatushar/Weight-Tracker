import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';

class WeightRepository {
  final Firestore _firestore;

  WeightRepository() : _firestore = Firestore.instance;

  Future<void> addWeightToDb(String uid, WeightModel model) {
    print("Model Id" + model.id);
    DocumentReference ref = _firestore
        .collection("Users")
        .document(uid)
        .collection("Weights")
        .document(model.id.isNotEmpty ? model.id : null);

    return ref.setData(model.id.isNotEmpty
        ? model.toJson()
        : model.copyWith(id: ref.documentID).toJson());
  }

  Future<void> deleteWeightFromDb(String uid, WeightModel model) {
    print("Model Id" + model.id);
    DocumentReference ref = _firestore
        .collection("Users")
        .document(uid)
        .collection("Weights")
        .document(model.id);

    return ref.delete();
  }

  Future<List<WeightModel>> getUserWeights(String uid) async {
    List<WeightModel> listWeightModel = List();
    QuerySnapshot weightQuery = await _firestore
        .collection("Users")
        .document(uid)
        .collection("Weights")
        .getDocuments();
    await Future.forEach(weightQuery.documents ?? [], ((element) async {
      listWeightModel.add(WeightModel.fromJson(element.data));
    }));
    return listWeightModel;
  }

  Stream<List<WeightModel>> getUserWeightsStream(String uid) {
    return _firestore
        .collection('Users')
        .document(uid)
        .collection("Weights")
        .snapshots()
        .map((snapShot) => (snapShot.documents
            .map((document) => WeightModel.fromJson(document.data))
            .toList())
          ..sort((a, b) {
            return b.selectedDate.difference(a.selectedDate).inSeconds;
          }));
  }
}
