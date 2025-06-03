import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addData(String path, Map<String, dynamic> data, String? docId) async {
    final docRef = _firestore.collection(path).doc(docId);
    await docRef.set(data);
  }

  Future<Map<String, dynamic>> getData(String path, String docId) async {
    final docRef = _firestore.collection(path).doc(docId);
    final doc = await docRef.get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<void> updateData(String path, Map<String, dynamic> data, String docId) async {
    final docRef = _firestore.collection(path).doc(docId);
    await docRef.update(data);
  }


}
