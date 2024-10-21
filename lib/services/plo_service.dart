import 'package:cloud_firestore/cloud_firestore.dart';

class PLOService {
  final CollectionReference ploCollection =
      FirebaseFirestore.instance.collection('PLOs');

  Future<DocumentReference<Object?>> addPLO(String title, String description) async {
    return await ploCollection.add({
      'title': title,
      'description': description,
    });
  }

  Future<void> updatePLO(String id, String title, String description) async {
    return await ploCollection.doc(id).update({
      'title': title,
      'description': description,
    });
  }

  Future<void> deletePLO(String id) async {
    return await ploCollection.doc(id).delete();
  }
}
