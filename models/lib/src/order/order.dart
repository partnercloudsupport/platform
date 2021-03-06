import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:models/models.dart';

part 'order.g.dart';

/// 销售订单状态
enum SalesOrderStatus {
  /// 待付款
  PENDING_PAYMENT,

  /// 待发货
  PENDING_DELIVERY,

  /// 已发货
  SHIPPED,

  /// 已完成
  COMPLETED,
}

// TODO: i18n处理
const SalesOrderStatusLocalizedMap = {
  SalesOrderStatus.PENDING_PAYMENT: "待付款",
  SalesOrderStatus.PENDING_DELIVERY: "待发货",
  SalesOrderStatus.SHIPPED: "已发货",
  SalesOrderStatus.COMPLETED: "已完成"
};

/// 需求订单状态
enum RequirementOrderStatus {
  /// 报价中
  PENDING_QUOTE,

  /// 已完成
  COMPLETED,

  /// 已失效
  CANCELLED
}

// TODO: i18n处理
const RequirementOrderStatusLocalizedMap = {
  RequirementOrderStatus.PENDING_QUOTE: "报价中",
  RequirementOrderStatus.COMPLETED: "已完成",
  RequirementOrderStatus.CANCELLED: "已失效"
};

/// 采购订单状态
enum PurchaseOrderStatus {
  /// 待处理
  WAIT_FOR_PROCESSING,

  /// 待确认
  PENDING_APPROVAL,

  /// 生产中
  IN_PRODUCTION,

  /// 已出库
  OUT_OF_STORE,

  /// 已完成
  COMPLETED
}

// TODO: i18n处理
const PurchaseOrderStatusLocalizedMap = {
  PurchaseOrderStatus.WAIT_FOR_PROCESSING: "待处理",
  PurchaseOrderStatus.PENDING_APPROVAL: "待确认",
  PurchaseOrderStatus.IN_PRODUCTION: "生产中",
  PurchaseOrderStatus.OUT_OF_STORE: "已出库",
  PurchaseOrderStatus.COMPLETED: "已完成"
};

/// 报价单状态
enum QuoteState {
  /// （工厂）待处理
  SELLER_SUBMITTED,

  ///（品牌）通过
  BUYER_APPROVED,

  /// （品牌）拒绝
  BUYER_REJECTED
}

// TODO: i18n处理
const QuoteStateLocalizedMap = {
  QuoteState.SELLER_SUBMITTED: "待处理",
  QuoteState.BUYER_APPROVED: "通过",
  QuoteState.BUYER_REJECTED: "拒绝"
};

enum ProductionProgressPhase {
  /// 备料
  MATERIAL_PREPARATION,

  /// 产前样衣确认
  SAMPLE_CONFIRM,

  /// 裁剪
  CUTTING,

  /// 车缝
  STITCHING,

  /// 验货
  INSPECTION,

  /// 发货
  DELIVERY
}

// TODO: i18n处理
const ProductionProgressPhaseLocalizedMap = {
  ProductionProgressPhase.MATERIAL_PREPARATION: "备料",
  ProductionProgressPhase.SAMPLE_CONFIRM: "产前样衣确认",
  ProductionProgressPhase.CUTTING: "裁剪",
  ProductionProgressPhase.STITCHING: "车缝",
  ProductionProgressPhase.INSPECTION: "验货",
  ProductionProgressPhase.DELIVERY: "发货"
};

@JsonSerializable()
class AbstractOrderModel extends ItemModel {
  /// 订单号
  String code;

  /// 合计数量
  int totalQuantity;

  /// 合计金额
  double totalPrice;

  /// 创建时间
  @JsonKey(name: "creationtime")
  DateTime creationTime;

  /// 地址
  AddressModel deliveryAddress;

  /// 备注
  String remarks;

  AbstractOrderModel({
    @required this.code,
    this.totalQuantity = 0,
    this.totalPrice = 0,
    this.creationTime,
    this.deliveryAddress,
    this.remarks,
  });
}

/// 订单
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
  /// 行号
  int entryNumber;

  /// 行单价
  double basePrice;

  /// 行数量
  int quantity;

  /// 行总价
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

/// 发货
@JsonSerializable()
class ConsignmentModel extends ItemModel {
  /// 发货单号
  String code;

  /// 发货状态
  String status;

  /// 物流单号
  String trackingID;

  /// 发货行
  List<ConsignmentEntryModel> consignmentEntries;

  ConsignmentModel({
    @required this.code,
    @required this.status,
    this.trackingID,
    this.consignmentEntries,
  });

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

/// 需求订单
@JsonSerializable()
class RequirementOrderModel extends OrderModel {
  /// 发布者
  BrandModel belongTo;

  /// 订单行
  List<RequirementOrderEntryModel> entries;

  /// 期望交货时间
  DateTime expectedDeliveryDate;

  /// 期望价格
  double expectedPrice;

  /// 加工类型
  String machiningType;

  /// 是否开具发票
  bool invoiceNeeded;

  /// 报价数
  int countOfQuotes;

  /// 附件
  List<MediaModel> attachments;

  /// 订单状态
  RequirementOrderStatus status;

  RequirementOrderModel({
    String code,
    this.status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.belongTo,
    this.entries,
    this.expectedDeliveryDate,
    this.expectedPrice,
    this.machiningType,
    this.invoiceNeeded = false,
    this.countOfQuotes,
    this.attachments,
  }) : super(
          code: code,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory RequirementOrderModel.fromJson(Map<String, dynamic> json) => _$RequirementOrderModelFromJson(json);

  static Map<String, dynamic> toJson(RequirementOrderModel model) => _$RequirementOrderModelToJson(model);
}

/// 需求订单行
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

/// 采购订单
@JsonSerializable()
class PurchaseOrderModel extends OrderModel {
  /// 采购者
  BrandModel belongTo;

  /// 采购行
  List<PurchaseOrderEntryModel> entries;

  /// 加工类型
  String machiningType;

  /// 是否开具发票
  bool invoiceNeeded;

  /// 当前阶段
  ProductionProgressPhase currentPhase;

  /// 附件
  List<MediaModel> attachments;

  /// 订单状态
  PurchaseOrderStatus status;

  /// 需求订单号
  String requirementOrderCode;

  /// 预计交货时间
  DateTime expectedDeliveryDate;

  //生产进度
  List<ProductionProgressModel> productionProgresses;

  PurchaseOrderModel({
    String code,
    this.status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.belongTo,
    this.entries,
    this.machiningType,
    this.currentPhase,
    this.attachments,
    this.requirementOrderCode,
    this.expectedDeliveryDate,
    this.productionProgresses,
  }) : super(
          code: code,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> json) => _$PurchaseOrderModelFromJson(json);

  static Map<String, dynamic> toJson(PurchaseOrderModel model) => _$PurchaseOrderModelToJson(model);
}

/// 采购订单行
@JsonSerializable()
class PurchaseOrderEntryModel extends OrderEntryModel {
  ApparelProductModel product;
  PurchaseOrderModel order;

  PurchaseOrderEntryModel({
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

  factory PurchaseOrderEntryModel.fromJson(Map<String, dynamic> json) => _$PurchaseOrderEntryModelFromJson(json);

  static Map<String, dynamic> toJson(PurchaseOrderEntryModel model) => _$PurchaseOrderEntryModelToJson(model);
}

/// 销售订单
@JsonSerializable()
class SalesOrderModel extends OrderModel {
  CompanyModel belongTo;
  List<SalesOrderEntryModel> entries;
  SalesOrderStatus status;

  SalesOrderModel({
    String code,
    this.status,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.belongTo,
    this.entries,
  }) : super(
          code: code,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) => _$SalesOrderModelFromJson(json);

  static Map<String, dynamic> toJson(SalesOrderModel model) => _$SalesOrderModelToJson(model);
}

/// 销售订单行
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

/// 报价单
@JsonSerializable()
class QuoteModel extends AbstractOrderModel {
  /// 报价状态
  QuoteState state;

  /// 需求订单号
  String requirementOrderCode;

  /// 采购订单号
  String purchaseOrderCode;

  /// 交货时间，工厂自己填写的交货时间，而不是需求订单中的交货时间
  DateTime expectedDeliveryDate;

  /// 报价工厂
  FactoryModel belongTo;

  /// 面料单价
  double unitPriceOfFabric;

  /// 辅料单价
  double unitPriceOfExcipients;

  /// 加工单价
  double unitPriceOfProcessing;

  /// 样衣费用
  double costOfSamples;

  /// 其他
  double costOfOther;

  /// 附件
  List<MediaModel> attachments;

  QuoteModel({
    String code,
    int totalQuantity,
    double totalPrice,
    DateTime creationTime,
    AddressModel deliveryAddress,
    String remarks,
    this.state,
    this.requirementOrderCode,
    this.purchaseOrderCode,
    this.belongTo,
    this.attachments,
    this.unitPriceOfFabric,
    this.unitPriceOfExcipients,
    this.unitPriceOfProcessing,
    this.costOfSamples,
    this.costOfOther,
    this.expectedDeliveryDate,
  }) : super(
          code: code,
          totalQuantity: totalQuantity,
          totalPrice: totalPrice,
          creationTime: creationTime,
          deliveryAddress: deliveryAddress,
          remarks: remarks,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);

  static Map<String, dynamic> toJson(QuoteModel model) => _$QuoteModelToJson(model);
}

/// 报价单行
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

/// 生产进度
@JsonSerializable()
class ProductionProgressModel extends ItemModel {
  /// 生产阶段
  ProductionProgressPhase phase;

  /// 数量
  int quantity;

  /// 凭证
  List<MediaModel> medias;

  /// 生产阶段顺序
  int sequence;

  /// 预计完成时间
  DateTime estimatedDate;

  /// 实际完成时间
  DateTime finishDate;

  ///备注
  String remarks;

  /// 采购订单
  PurchaseOrderModel order;

  ProductionProgressModel({
    this.phase,
    this.quantity,
    this.medias,
    this.sequence,
    this.estimatedDate,
    this.finishDate,
    this.order,
    this.remarks
  });

  factory ProductionProgressModel.fromJson(Map<String, dynamic> json) => _$ProductionProgressModelFromJson(json);

  static Map<String, dynamic> toJson(ProductionProgressModel model) => _$ProductionProgressModelToJson(model);
}

//订单状态model，用于订单状态控件的List传入
@JsonSerializable()
class OrderStatusModel extends ItemModel {
  String code;
  String name;
  int sort;

  OrderStatusModel({
    this.code,
    this.name,
    this.sort,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => _$OrderStatusModelFromJson(json);

  static Map<String, dynamic> toJson(OrderStatusModel model) => _$OrderStatusModelToJson(model);

}