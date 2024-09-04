

import 'package:equatable/equatable.dart';

class Package extends Equatable {
  final int? id;
  final String createdAt;
  final String pkgName;
  final int price;
  final List<String> desc;
  final String type;

  const Package({
    this.id,
    required this.createdAt,
    required this.pkgName,
    required this.price,
    required this.desc,
    required this.type,
  });

  @override
  List<Object?> get props => [];
}