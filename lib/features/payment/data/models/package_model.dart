import '../../domain/entities/package.dart';

class PackageModel extends Package {
  PackageModel(
      {super.id,
      required super.createdAt,
      required super.pkgName,
      required super.price,
      required super.desc,
      required super.type});


  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
      id: json["id"],
      createdAt: json["created_at"],
      pkgName: json["pkg_name"],
      price: json["price"],
      desc: List<String>.from(json["desc"].map((x) => x)),
      type: json["type"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "created_at": createdAt,
      "pkg_name": pkgName,
      "price": price,
      "desc": List<dynamic>.from(desc.map((x) => x)),
      "type": type,
  };
}
