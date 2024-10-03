import 'package:hr_career_platform/features/payment/domain/entities/payment.dart';

class PaymentModel extends Payment {
  const PaymentModel(
      {
          super.id,
       super.createdAt,
      required super.jobId,
      required super.companyId,
      required super.amount,
      required super.refId,
      required super.amountTxt,
      required super.fee,
      required super.description,
      required super.metadata,
      required super.pkg});

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
      id: json["id"],
      createdAt: json["created_at"],
      jobId: json["job_id"],
      companyId: json["company_id"],
      amount: json["amount"],
      refId: json["ref_id"],
      amountTxt: json["amount_txt"],
      fee: json["fee"],
      description: json["description"],
      metadata: json["metadata"],
      pkg: json["pkg"],
  );

  factory PaymentModel.fromPayment(Payment payment) => PaymentModel(
      jobId: payment.jobId,
      amount: payment.amount,
      refId: payment.refId,
      amountTxt: payment.amountTxt,
      fee: payment.fee,
      description: payment.description,
      metadata: payment.metadata,
      pkg: payment.pkg,
      companyId: payment.companyId,
  );

  Map<String, dynamic> toJson() => {

      "job_id": jobId,
      "company_id": companyId,
      "amount": amount,
      "ref_id": refId,
      "amount_txt": amountTxt,
      "fee": fee,
      "description": description,
      "metadata": metadata,
      "pkg": pkg,
  };
}
