import 'dart:math';

String generateOrderId() {
  DateTime now = DateTime.now();
  int randomIds = Random().nextInt(99999);
  String id = "${now.microsecondsSinceEpoch}_$randomIds";
  return id;
}
