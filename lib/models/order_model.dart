class OrderModel {
  String productId;
  String categoryId;
  String productName;
  String categoryName;
  String productPrice;
  String productImage;
  String deliveryTime;
  String productDes;
  String createdAt, updatedAt;
  bool status;
  String customerName;
  String customerPhone;
  String customerAddress;
  String customerId;
  int productQuantity;

  OrderModel({
    required this.productId,
    required this.categoryId,
    required this.productName,
    required this.categoryName,
    required this.productPrice,
    required this.productImage,
    required this.deliveryTime,
    required this.productDes,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerId,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'categoryId': this.categoryId,
      'productName': this.productName,
      'categoryName': this.categoryName,
      'productPrice': this.productPrice,
      'productImage': this.productImage,
      'deliveryTime': this.deliveryTime,
      'productDes': this.productDes,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'status': this.status,
      'customerName': this.customerName,
      'customerPhone': this.customerPhone,
      'customerAddress': this.customerAddress,
      'customerId': this.customerId,
      'productQuantity': this.productQuantity,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      productId: map['productId'] as String,
      categoryId: map['categoryId'] as String,
      productName: map['productName'] as String,
      categoryName: map['categoryName'] as String,
      productPrice: map['productPrice'] as String,
      productImage: map['productImage'] as String,
      deliveryTime: map['deliveryTime'] as String,
      productDes: map['productDes'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      status: map['status'] as bool,
      customerName: map['customerName'] as String,
      customerPhone: map['customerPhone'] as String,
      customerAddress: map['customerAddress'] as String,
      customerId: map['customerId'] as String,
      productQuantity: map['productQuantity'] as int,
    );
  }
}
