import 'package:equatable/equatable.dart';

class Payment extends Equatable{
 final int? id;
 final String? createdAt;
 final int jobId;
 final String companyId;
 final int amount;
 final String refId;
 final String amountTxt;
 final String fee;
 final String description;
 final dynamic metadata;
 final int pkg;

 const Payment({
     this.id,
     this.createdAt,
    required this.jobId,
    required this.companyId,
    required this.amount,
    required this.refId,
    required this.amountTxt,
    required this.fee,
    required this.description,
    required this.metadata,
    required this.pkg,
  });

  @override
  List<Object?> get props =>[];
}