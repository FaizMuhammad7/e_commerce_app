import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DbConstants {
  static var mainRef = FirebaseFirestore.instance;
  static var usersRef = mainRef.collection('users');
  static var productsRef = mainRef.collection('products');
  static var categoriesRef = mainRef.collection('categories');
  static var cartRef = mainRef.collection('cart');
  static var orderRef = mainRef.collection('orders');
}

class AuthConstants {
  static User? get currentUser => FirebaseAuth.instance.currentUser;
  static bool get isUserLoggedIn => currentUser != null;
  static String? get currentUserId => currentUser?.uid;
}

class StorageConstants {
  static var mainRef = FirebaseStorage.instance.ref();
  static var productRef = mainRef.child('product_images');
  static var profileRef = mainRef.child('profile_pictures');
  static var categoryRef = mainRef.child('category_pictures');
}
