import 'dart:convert';

class OrderPix {
  String image;
  String code;
  double value;

  OrderPix({
    required this.image,
    required this.code,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'code': code,
      'value': value,
    };
  }

  factory OrderPix.fromMap(Map<String, dynamic> map) {
    return OrderPix(
      image: map['image'] ?? '',
      code: map['code'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPix.fromJson(String source) =>
      OrderPix.fromMap(json.decode(source));

  OrderPix copyWith({
    String? image,
    String? code,
    double? value,
  }) {
    return OrderPix(
      image: image ?? this.image,
      code: code ?? this.code,
      value: value ?? this.value,
    );
  }
}
