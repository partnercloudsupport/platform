import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:models/models.dart';

part 'order.g.dart';

@JsonSerializable()
class AbstractOrderModel extends ItemModel {
  String code;
  String status;
  int totalQuantity;
  double totalPrice;
  @JsonKey(name: "creationtime")
  DateTime creationTime;
  /// 地址
  AddressModel deliveryAddress;

  /// 备注
  String remarks;

  AbstractOrderModel({
    @required this.code,
    @required this.status,
    this.totalQuantity = 0,
    this.totalPrice = 0,
    this.creationTime,
    this.deliveryAddress,
    this.remarks,
  });
}

@JsonSerializable()
class OrderModel extends AbstractOrderModel {
  OrderModel({
    String code,
    String status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
  }) : super(
          code: code,
          status: status,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  static Map<String, dynamic> toJson(OrderModel model) => _$OrderModelToJson(model);
}

@JsonSerializable()
class AbstractOrderEntryModel extends ItemModel {
  int entryNumber;
  double basePrice;
  int quantity;
  double totalPrice;

  AbstractOrderEntryModel({
    @required this.entryNumber,
    this.basePrice,
    this.quantity,
    this.totalPrice,
  });

  factory AbstractOrderEntryModel.fromJson(Map<String, dynamic> json) => _$AbstractOrderEntryModelFromJson(json);

  static Map<String, dynamic> toJson(AbstractOrderEntryModel model) => _$AbstractOrderEntryModelToJson(model);
}

@JsonSerializable()
class OrderEntryModel extends AbstractOrderEntryModel {
  OrderEntryModel({
    int entryNumber,
    double basePrice,
    int quantity,
    double totalPrice,
  }) : super(
          entryNumber: entryNumber,
          basePrice: basePrice,
          quantity: quantity,
          totalPrice: totalPrice,
        );

  factory OrderEntryModel.fromJson(Map<String, dynamic> json) => _$OrderEntryModelFromJson(json);

  static Map<String, dynamic> toJson(OrderEntryModel model) => _$OrderEntryModelToJson(model);
}

@JsonSerializable()
class CartModel extends AbstractOrderModel {
  CompanyModel belongTo;
  List<CartEntryModel> entries;

  CartModel({
    String code,
    String status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.belongTo,
    this.entries,
  }) : super(
          code: code,
          status: status,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

  static Map<String, dynamic> toJson(CartModel model) => _$CartModelToJson(model);
}

@JsonSerializable()
class CartEntryModel extends AbstractOrderEntryModel {
  ProductModel product;
  OrderModel order;

  CartEntryModel({
    int entryNumber,
    this.product,
    this.order,
    double basePrice,
    int quantity,
    double totalPrice,
  }) : super(
          entryNumber: entryNumber,
          basePrice: basePrice,
          quantity: quantity,
          totalPrice: totalPrice,
        );

  factory CartEntryModel.fromJson(Map<String, dynamic> json) => _$CartEntryModelFromJson(json);

  static Map<String, dynamic> toJson(CartEntryModel model) => _$CartEntryModelToJson(model);
}

@JsonSerializable()
class ConsignmentModel extends ItemModel {
  String code;
  String status;
  List<ConsignmentEntryModel> consignmentEntries;

  ConsignmentModel({@required this.code, @required this.status, this.consignmentEntries});

  factory ConsignmentModel.fromJson(Map<String, dynamic> json) => _$ConsignmentModelFromJson(json);

  static Map<String, dynamic> toJson(ConsignmentModel model) => _$ConsignmentModelToJson(model);
}

@JsonSerializable()
class ConsignmentEntryModel extends ItemModel {
  AbstractOrderEntryModel orderEntry;
  ConsignmentModel consignment;

  ConsignmentEntryModel({
    @required this.orderEntry,
    this.consignment,
  });

  factory ConsignmentEntryModel.fromJson(Map<String, dynamic> json) => _$ConsignmentEntryModelFromJson(json);

  static Map<String, dynamic> toJson(ConsignmentEntryModel model) => _$ConsignmentEntryModelToJson(model);
}

@JsonSerializable()
class RequirementOrderModel extends OrderModel {
  BrandModel belongTo;
  List<RequirementOrderEntryModel> entries;

  /// 交货时间
  DateTime expectedDeliveryDate;

  RequirementOrderModel({
    String code,
    String status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.belongTo,
    this.entries,
    this.expectedDeliveryDate,
  }) : super(
          code: code,
          status: status,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory RequirementOrderModel.fromJson(Map<String, dynamic> json) => _$RequirementOrderModelFromJson(json);

  static Map<String, dynamic> toJson(RequirementOrderModel model) => _$RequirementOrderModelToJson(model);
}

@JsonSerializable()
class RequirementOrderEntryModel extends OrderEntryModel {
  ApparelProductModel product;
  RequirementOrderModel order;

  RequirementOrderEntryModel({
    int entryNumber,
    this.product,
    this.order,
    double basePrice,
    int quantity,
    double totalPrice,
  }) : super(
          entryNumber: entryNumber,
          basePrice: basePrice,
          quantity: quantity,
          totalPrice: totalPrice,
        );

  factory RequirementOrderEntryModel.fromJson(Map<String, dynamic> json) => _$RequirementOrderEntryModelFromJson(json);

  static Map<String, dynamic> toJson(RequirementOrderEntryModel model) => _$RequirementOrderEntryModelToJson(model);
}

@JsonSerializable()
class PurchaseOrderModel extends OrderModel {
  BrandModel belongTo;
  List<PurchaseOrderEntryModel> entries;

  PurchaseOrderModel({
    String code,
    String status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.belongTo,
    this.entries,
  }) : super(
          code: code,
          status: status,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) => _$PurchaseOrderModelFromJson(json);

  static Map<String, dynamic> toJson(PurchaseOrderModel model) => _$PurchaseOrderModelToJson(model);
}

@JsonSerializable()
class PurchaseOrderEntryModel extends OrderEntryModel {
  ApparelProductModel product;
  PurchaseOrderModel order;

  PurchaseOrderEntryModel({
    int entryNumber,
    this.product,
    this.order,
    double basePrice,
    int quantity,
    double totalPrice,
  }) : super(
          entryNumber: entryNumber,
          basePrice: basePrice,
          quantity: quantity,
          totalPrice: totalPrice,
        );

  factory PurchaseOrderEntryModel.fromJson(Map<String, dynamic> json) => _$PurchaseOrderEntryModelFromJson(json);

  static Map<String, dynamic> toJson(PurchaseOrderEntryModel model) => _$PurchaseOrderEntryModelToJson(model);
}

@JsonSerializable()
class SalesOrderModel extends OrderModel {
  CompanyModel belongTo;
  List<SalesOrderEntryModel> entries;

  SalesOrderModel({
    String code,
    String status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.belongTo,
    this.entries,
  }) : super(
          code: code,
          status: status,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) => _$SalesOrderModelFromJson(json);

  static Map<String, dynamic> toJson(SalesOrderModel model) => _$SalesOrderModelToJson(model);
}

@JsonSerializable()
class SalesOrderEntryModel extends OrderEntryModel {
  ApparelProductModel product;
  SalesOrderModel order;

  SalesOrderEntryModel({
    int entryNumber,
    this.product,
    this.order,
    double basePrice,
    int quantity,
    double totalPrice,
  }) : super(
          entryNumber: entryNumber,
          basePrice: basePrice,
          quantity: quantity,
          totalPrice: totalPrice,
        );

  factory SalesOrderEntryModel.fromJson(Map<String, dynamic> json) => _$SalesOrderEntryModelFromJson(json);

  static Map<String, dynamic> toJson(SalesOrderEntryModel model) => _$SalesOrderEntryModelToJson(model);
}

@JsonSerializable()
class QuoteModel extends AbstractOrderModel {
  String state;
  /// 需求订单号
  String requirementOrderCode;
  /// 交货时间
  DateTime expectedDeliveryDate;
  FactoryModel belongTo;

  /// 面料单价
  double unitPriceOfFabric;

  /// 辅料单价
  double unitPriceOfExcipients;

  /// 加工单价
  double unitPriceOfProcessing;

  /// 样衣费用
  double costOfSamples;

  /// 附件
  List<String> attachments;

  QuoteModel({
    String code,
    String status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.state,
    this.requirementOrderCode,
    this.belongTo,
    this.attachments
  }) : super(
          code: code,
          status: status,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);

  static Map<String, dynamic> toJson(QuoteModel model) => _$QuoteModelToJson(model);
}

@JsonSerializable()
class QuoteEntryModel extends AbstractOrderEntryModel {
  ApparelProductModel product;
  QuoteModel order;

  QuoteEntryModel({
    int entryNumber,
    double basePrice,
    int quantity,
    double totalPrice,
    this.product,
    this.order,
  }) : super(
          entryNumber: entryNumber,
          basePrice: basePrice,
          quantity: quantity,
          totalPrice: totalPrice,
        );

  factory QuoteEntryModel.fromJson(Map<String, dynamic> json) => _$QuoteEntryModelFromJson(json);

  static Map<String, dynamic> toJson(QuoteEntryModel model) => _$QuoteEntryModelToJson(model);
}

@JsonSerializable()
class ProductionOrderModel extends ConsignmentModel {
  CompanyModel assignedTo;

  ProductionOrderModel({
    String code,
    String status,
    List<ConsignmentEntryModel> consignmentEntries,
    this.assignedTo,
  }) : super(
          code: code,
          status: status,
          consignmentEntries: consignmentEntries,
        );

  factory ProductionOrderModel.fromJson(Map<String, dynamic> json) => _$ProductionOrderModelFromJson(json);

  static Map<String, dynamic> toJson(ProductionOrderModel model) => _$ProductionOrderModelToJson(model);
}

@JsonSerializable()
class ProductionOrderEntryModel extends ConsignmentEntryModel {
  ProductionOrderEntryModel({
    AbstractOrderEntryModel orderEntry,
    ConsignmentModel consignment,
  }) : super(
          orderEntry: orderEntry,
          consignment: consignment,
        );

  factory ProductionOrderEntryModel.fromJson(Map<String, dynamic> json) => _$ProductionOrderEntryModelFromJson(json);

  static Map<String, dynamic> toJson(ProductionOrderEntryModel model) => _$ProductionOrderEntryModelToJson(model);
}
