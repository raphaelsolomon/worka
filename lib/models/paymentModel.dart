// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromMap(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromMap(String str) =>
    PaymentModel.fromMap(json.decode(str));

String paymentModelToMap(PaymentModel data) => json.encode(data.toMap());

class PaymentModel {
  PaymentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  String toString() {
    return 'PaymentModel{status: $status, message: $message, data: $data}';
  }

  final bool status;
  final String message;
  final Data data;

  factory PaymentModel.fromMap(Map<String, dynamic> json) => PaymentModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.amount,
    required this.currency,
    required this.transactionDate,
    required this.status,
    required this.reference,
    required this.domain,
    required this.metadata,
    required this.gatewayResponse,
    this.message,
    required this.channel,
    required this.ipAddress,
    required this.log,
    this.fees,
    required this.authorization,
    required this.customer,
    required this.plan,
    required this.requestedAmount,
  });

  @override
  String toString() {
    return 'Data{amount: $amount, currency: $currency, transactionDate: $transactionDate, status: $status, reference: $reference, domain: $domain, metadata: $metadata, gatewayResponse: $gatewayResponse, message: $message, channel: $channel, ipAddress: $ipAddress, log: $log, fees: $fees, authorization: $authorization, customer: $customer, plan: $plan, requestedAmount: $requestedAmount}';
  }

  final int amount;
  final String currency;
  final DateTime transactionDate;
  final String status;
  final String reference;
  final String domain;
  final int metadata;
  final String gatewayResponse;
  final dynamic message;
  final String channel;
  final String ipAddress;
  final Log log;
  final dynamic fees;
  final Authorization authorization;
  final Customer customer;
  final String plan;
  final int requestedAmount;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        amount: json["amount"],
        currency: json["currency"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        status: json["status"],
        reference: json["reference"],
        domain: json["domain"],
        metadata: json["metadata"],
        gatewayResponse: json["gateway_response"],
        message: json["message"],
        channel: json["channel"],
        ipAddress: json["ip_address"],
        log: Log.fromMap(json["log"]),
        fees: json["fees"],
        authorization: Authorization.fromMap(json["authorization"]),
        customer: Customer.fromMap(json["customer"]),
        plan: json["plan"],
        requestedAmount: json["requested_amount"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "currency": currency,
        "transaction_date": transactionDate.toIso8601String(),
        "status": status,
        "reference": reference,
        "domain": domain,
        "metadata": metadata,
        "gateway_response": gatewayResponse,
        "message": message,
        "channel": channel,
        "ip_address": ipAddress,
        "log": log.toMap(),
        "fees": fees,
        "authorization": authorization.toMap(),
        "customer": customer.toMap(),
        "plan": plan,
        "requested_amount": requestedAmount,
      };
}

class Authorization {
  Authorization({
    required this.authorizationCode,
    required this.cardType,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    required this.bin,
    required this.bank,
    required this.channel,
    required this.signature,
    required this.reusable,
    required this.countryCode,
    required this.accountName,
  });

  @override
  String toString() {
    return 'Authorization{authorizationCode: $authorizationCode, cardType: $cardType, last4: $last4, expMonth: $expMonth, expYear: $expYear, bin: $bin, bank: $bank, channel: $channel, signature: $signature, reusable: $reusable, countryCode: $countryCode, accountName: $accountName}';
  }

  final String authorizationCode;
  final String cardType;
  final String last4;
  final String expMonth;
  final String expYear;
  final String bin;
  final String bank;
  final String channel;
  final String signature;
  final bool reusable;
  final String countryCode;
  final String accountName;

  factory Authorization.fromMap(Map<String, dynamic> json) => Authorization(
        authorizationCode: json["authorization_code"],
        cardType: json["card_type"],
        last4: json["last4"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        bin: json["bin"],
        bank: json["bank"],
        channel: json["channel"],
        signature: json["signature"],
        reusable: json["reusable"],
        countryCode: json["country_code"],
        accountName: json["account_name"],
      );

  Map<String, dynamic> toMap() => {
        "authorization_code": authorizationCode,
        "card_type": cardType,
        "last4": last4,
        "exp_month": expMonth,
        "exp_year": expYear,
        "bin": bin,
        "bank": bank,
        "channel": channel,
        "signature": signature,
        "reusable": reusable,
        "country_code": countryCode,
        "account_name": accountName,
      };
}

class Customer {
  Customer({
    required this.id,
    required this.customerCode,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final int id;
  final String customerCode;
  final String firstName;
  final String lastName;
  final String email;

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerCode: json["customer_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  @override
  String toString() {
    return 'Customer{id: $id, customerCode: $customerCode, firstName: $firstName, lastName: $lastName, email: $email}';
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "customer_code": customerCode,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      };
}

class Log {
  Log({
    required this.timeSpent,
    required this.attempts,
    this.authentication,
    required this.errors,
    required this.success,
    required this.mobile,
    required this.input,
    this.channel,
    required this.history,
  });

  final int timeSpent;
  final int attempts;
  final dynamic authentication;
  final int errors;
  final bool success;
  final bool mobile;
  final List<dynamic> input;
  final dynamic channel;
  final List<History> history;

  factory Log.fromMap(Map<String, dynamic> json) => Log(
        timeSpent: json["time_spent"],
        attempts: json["attempts"],
        authentication: json["authentication"],
        errors: json["errors"],
        success: json["success"],
        mobile: json["mobile"],
        input: List<dynamic>.from(json["input"].map((x) => x)),
        channel: json["channel"],
        history:
            List<History>.from(json["history"].map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "time_spent": timeSpent,
        "attempts": attempts,
        "authentication": authentication,
        "errors": errors,
        "success": success,
        "mobile": mobile,
        "input": List<dynamic>.from(input.map((x) => x)),
        "channel": channel,
        "history": List<dynamic>.from(history.map((x) => x.toMap())),
      };
}

class History {
  History({
    required this.type,
    required this.message,
    required this.time,
  });

  final String type;
  final String message;
  final int time;

  @override
  String toString() {
    return 'History{type: $type, message: $message, time: $time}';
  }

  factory History.fromMap(Map<String, dynamic> json) => History(
        type: json["type"],
        message: json["message"],
        time: json["time"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "message": message,
        "time": time,
      };
}
