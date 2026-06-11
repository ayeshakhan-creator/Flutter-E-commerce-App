import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> placeOrder(Map<String, dynamic> data) async {
    try {
      await db.collection("orders").add(data);
    } catch (e) {
      throw Exception("Failed to place order: $e");
    }
  }
}