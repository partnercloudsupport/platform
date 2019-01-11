import 'package:b2b_commerce/src/business/orders/production_progresses.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';


const statuses = <EnumModel>[
  EnumModel('MATERIAL_PREPARATION', '备料'),
  EnumModel('SAMPLE_CONFIRM', '产前样衣确认'),
  EnumModel('CUTTING', '裁剪'),
  EnumModel('STITCHING', '车缝'),
  EnumModel('INSPECTION', '验货'),
  EnumModel('DELIVERY', '发货'),
];

final List<Widget> _list = new List();

final String defaultPicUrl = "https://gss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/zhidao/wh%3D600%2C800/sign=05e1074ebf096b63814c56563c03ab7c/8b82b9014a90f6037c2a5c263812b31bb051ed3d.jpg";

class PurchaseDetailPage extends StatelessWidget {
  final PurchaseOrderModel order;

  PurchaseDetailPage({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('采购订单明细'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: PurchaseOrderContent(order)
    );
  }

}


class PurchaseOrderContent extends StatelessWidget {

  final PurchaseOrderModel order;

  PurchaseOrderContent(this.order);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _bildEntryUi(context),
        _buildPurchaseProductionProgresse(context),
        _buildFactoryInfo(context),
        _buildDocutment(context),
        _buildDeliveryAddress(context),
        _buildBottom(context)
      ],
    );
  }
//包装订单行
  Widget _bildEntryUi(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children:
        _buildOrderEntry(context),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
//构建订单行UI
  List<Widget> _buildOrderEntry(BuildContext context){
    return order.entries.map((entry) {
      return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            children: <Widget>[
              Image.network(
                entry.product.thumbnail,
                width: 110,
                height: 110,
                fit: BoxFit.fill,
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              entry.product.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:FontWeight.w500
                              ),
                            )
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '货号：' + entry.product.skuID,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:FontWeight.w500
                              ),
                            )
                          )
                        ],
                      )
                  )
              )
            ],
          ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
      );
    }).toList();
  }
//构建底部UI
  Widget _buildBottom(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text('采购订单号：' + order.code),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child:
              Text('需求订单号：' + order.code)
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('订单生成时间：' + order.creationTime.toString())
          ),
          Align(
              alignment: Alignment.centerLeft,
              child:
              Text('预计交货时间：' + order.creationTime.toString())
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
//构建工厂信息UI
  Widget _buildFactoryInfo(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(13),
            child:Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          order.belongTo.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                     Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                        ],
                      )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          '报价：',
                        style:TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: <Widget>[
                          Text('广州白云'),
                          Icon(Icons.chevron_right),
                        ],
                      )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                      Text('历史接单26单，报价成功率34%'),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            title: Text('加工类型'),
            trailing: Text(order.machiningType),
          ),
          new Divider(),
          ListTile(
            title: Text('是否开具发票'),
            trailing: Text(order.invoiceNeeded==true?'是':'否'),
          ),
          new Divider(),
          ListTile(
            title: Text('合计金额'),
            trailing: Text(
                '￥'+order.totalPrice.toString(),
                style:TextStyle(
                    fontSize: 18,
                    color:Colors.red
                )
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
//构建收货信息UI
  Widget _buildDeliveryAddress(BuildContext context) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                  Icons.add_location,
                color: Colors.orange,
              ),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(order.deliveryAddress.fullname),
                  ),
                  Expanded(
                      child: Text(order.deliveryAddress.cellphone)
                  )
                ],
              ),
              subtitle: Text(order.deliveryAddress.region.name + order.deliveryAddress.city.name + order.deliveryAddress.cityDistrict.name + order.deliveryAddress.line1),
              trailing: Icon(Icons.chevron_right),
            ),
            Divider(
              height: 1,
              color: Colors.indigo,
            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            ListTile(
              title: Text("物流信息"),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
      );
  }
//构建生产进度UI
  Widget _buildPurchaseProductionProgresse(BuildContext context) {
    int _index = 0;
    for(int i=0;i<order.productionProgresses.length;i++){
      if(order.currentPhase == order.productionProgresses[i].phase){
          _index = order.productionProgresses[i].sequence;
          break;
      }
    }
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
          PurchaseProductionProgresse(order.productionProgresses[_index-1],false),
          PurchaseProductionProgresse(order.productionProgresses[_index],true),
          Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(50, 0, 10, 0),
              child:
              RaisedButton(
                elevation:0,
                color: Colors.white,
                child: Text(
                  '查看全部', style: TextStyle(
                    color: Colors.orange),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductionProgressePage(order: order),
                    ),
                  );
                },
              )
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
//构建附件UI
  Widget _buildDocutment(BuildContext context){
    return PurchaseDocument(order);
  }
}

//生产进度TimeLine
class PurchaseProductionProgresse extends StatelessWidget {
  final ProductionProgressModel progressModel;
  final bool isCurrentStatus;

  @override
  PurchaseProductionProgresse(this.progressModel,this.isCurrentStatus);

  @override
  Widget build(BuildContext context) {
    return  _buildProductionProgress(context);
  }

  //TimeLineUI
  Widget _buildProductionProgress(BuildContext context){
    return  Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child:  _buildProgressTimeLine(context)
        ),
        Positioned(
          top: 30.0,
          bottom: 0.0,
          left: 17.5,
          child: Container(
            height: double.infinity,
            width: 1.3,
            color: isCurrentStatus == true ? Colors.orangeAccent : Colors.black45,
          ),
        ),
        Positioned(
          top: 26.0,
          left: 10.0,
          child: Container(
            height: 16.0,
            width: 16.0,
            child: Container(
              margin: EdgeInsets.all(3.0),
              height: 16.0,
              width: 16.0,
              decoration:
              BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrentStatus == true ? Colors.orange : Colors.black
              ),
            ),
          ),
        )
      ],
    );
  }
//TimeLineUI右边的Card部分
  Widget _buildProgressTimeLine(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
      width: double.infinity,
      child: Column(
            children: <Widget>[
              ListTile(
                title:  Text(
                    ProductionProgressPhaseLocalizedMap[progressModel.phase],
                    style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCurrentStatus==true?Colors.orange:Colors.black54,
                        fontSize: 18
                    )),
                trailing:  Text(
                  '已延期2天',
                  style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child:Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: new Text(
                                '预计完成时间' ,
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child:  Text(
                                progressModel.estimatedDate.toString(),
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.date_range),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:  Text(
                                '实际完成时间' ,
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child:  Text(
                                progressModel.finishDate.toString(),
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500)),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 48,
                              )
                          )
                        ],
                      ),
                    ],
                  )
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 35,
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child:Row(
                      children: <Widget>[
                        Expanded(
                          child:  Text(
                              '数量' ,
                              style:  TextStyle(
                                  fontWeight: FontWeight.w500)),
                        ),
                        Align(
                          alignment : Alignment.centerRight,
                          child:  Text(
                              progressModel.quantity.toString(),
                              style:  TextStyle(
                                  fontWeight: FontWeight.w500)),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.keyboard_arrow_right),
                          ),
                        )
                      ],
                    ),)
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 35,
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child:Row(
                      children: <Widget>[
                        Expanded(
                          child:  Text(
                              '凭证',
                              style:  TextStyle(
                                  fontWeight: FontWeight.w500)),
                          flex: 4,
                        ),
                        Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.chevron_right),
                              ),
                            )
                        ),
                      ],
                    ),)
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: PurchaseVoucherPic(progressModel)
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("备注"),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(progressModel.remarks)
                        )
                      ]
                  )
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: isCurrentStatus==true?
                  RaisedButton(
                    color: Colors.orange,
                    child: Text(
                      '验货完成', style: TextStyle(
                        color: Colors.white),
                    ),
                    onPressed: () {},
                  ):null
              )
            ],
      ),
    );
  }

}

//生产进度凭证图片
class PurchaseVoucherPic extends StatelessWidget {
  final ProductionProgressModel progressModel;

  @override
  PurchaseVoucherPic(this.progressModel);

  @override
  Widget build(BuildContext context) {
    return _buildPicRow(context);
  }

  Widget _buildPicRow(BuildContext context){
    return Row(
        children: _buildPicList(context)
    );
  }

//构造凭证横向图片UI
  List<Widget> _buildPicList(BuildContext context) {
    List<Widget> _listPic = new List();
    int mediasNumber = 4;
    if(progressModel.medias.length < 4){
      mediasNumber = progressModel.medias.length;
    }
    for (int i = 0; i < mediasNumber; i++) {
      _listPic.add(
          Expanded(
            child: Image.network(
              progressModel.medias[i] == null ? defaultPicUrl : progressModel.medias[i],
              width: 50,
              height: 50,
              fit: BoxFit.scaleDown,
            ),
          )
      );
    }
    if(_listPic.length < 4){
      for (int i = 0; i <= 4 - _listPic.length; i++) {
        _listPic.add(
            Expanded(
              child: Image.network(
                defaultPicUrl,
                width: 50,
                height: 50,
                fit: BoxFit.scaleDown,
              ),
            )
        );
      }
    }
    return _listPic;
  }

}

//附件
class PurchaseDocument extends StatelessWidget{
  final PurchaseOrderModel order;

  PurchaseDocument(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child:  Column(
              children: <Widget>[
                _buildDoc(context),
              ],
            ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildDoc(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
          children: _buildDocumentInfo(context)
      ),
    );
  }

  List<Widget> _buildDocumentInfo(BuildContext context){
    List<Widget> _docList = new List();
    int docCount = 2;
    if (order.attachments.length < 2) {
      docCount = order.attachments.length;
    }
    for (int i = 0; i < docCount; i++) {
      _docList.add(
          Row(
            children: <Widget>[
              Expanded(
                  child: Image.network(
                    "http://img.aso.aizhan.com/icon/f7/d0/cc/f7d0cc9b577ff84ec59b6d9932606c33.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.scaleDown,
                  ),
                flex: 1,
              ),
              Expanded(
                child: Text(
                  order.attachments[i],
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
                flex: 4,
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          )
      );
      _docList.add(Divider());
    }
    _docList.removeLast();
    return _docList;
  }

}