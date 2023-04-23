import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_ar/models/furniture_model.dart';
import 'package:furniture_ar/models/user_model.dart';

class DatabaseController {
  final String? uid;

  DatabaseController({this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("Users");

  final CollectionReference _furnitureCollection =
      FirebaseFirestore.instance.collection("Furniture");

  Future<void> setUserData(UserModel user) async {
    try {
      await _userCollection.doc(user.uid).set({
        "uid": user.uid,
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      DocumentSnapshot userSnap = await _userCollection.doc(uid).get();
      return UserModel(
        uid: uid,
        name: userSnap["name"],
        email: userSnap["email"],
        phone: userSnap["phone"],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FurnitureModel>> getFurnitures() async {
    try {
      QuerySnapshot querySnapshot = await _furnitureCollection.get();
      List<QueryDocumentSnapshot> listSnap = querySnapshot.docs;
      return _furnitureModelFromQueryDocSnap(listSnap);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FurnitureModel>> getFilteredFurnitures(String type) async {
    try {
      QuerySnapshot querySnapshot =
          await _furnitureCollection.where("type", isEqualTo: type).get();
      List<QueryDocumentSnapshot> listSnap = querySnapshot.docs;
      return _furnitureModelFromQueryDocSnap(listSnap);
    } catch (e) {
      rethrow;
    }
  }

  List<FurnitureModel> _furnitureModelFromQueryDocSnap(
      List<QueryDocumentSnapshot> listSnap) {
    return listSnap
        .map((dynamic e) => FurnitureModel(
              id: e.data()["id"],
              name: e.data()["name"],
              type: e.data()["type"],
              material: e.data()["material"],
              price: e.data()["price"],
              mrp: e.data()["mrp"],
              modelLink: e.data()["modelLink"],
              modelThumbnail: e.data()["modelThumbnail"],
            ))
        .toList();
  }
}
