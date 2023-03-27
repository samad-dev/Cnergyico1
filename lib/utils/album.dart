class Album {
  final String deliverybased;
  final String quantity;
  final String depot;
  final String date;
  final String cid;
  final String bankinfo;
  final String producttype;
  final String amount;
  final String transactionid;
  final String vehicle;

  Album({
    required this.deliverybased,
    required this.quantity,
    required this.depot,
    required this.date,
    required this.cid,
    required this.bankinfo,
    required this.producttype,
    required this.amount,
    required this.transactionid,
    required this.vehicle,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      deliverybased: json['delivery_based'],
      quantity: json['quantity'],
      depot: json['depot'],
      date: json['date'],
      cid: json['cus_id'],
      bankinfo: json['bank_info'],
      producttype: json['product_type'],
      amount: json['amount'],
      transactionid: json['transection_id'],
      vehicle: json['vehicle'],
    );
  }
}