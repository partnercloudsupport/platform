import 'dart:async';

import 'package:models/models.dart';
import 'package:services/services.dart';

class ApparelProductBLoC extends BLoCBase {
  List<ApparelProductModel> products;
  ApparelProductModel currentProduct;

  // 工厂模式
  factory ApparelProductBLoC() => _getInstance();

  static ApparelProductBLoC get instance => _getInstance();
  static ApparelProductBLoC _instance;

  ApparelProductBLoC._internal() {
    // 初始化
    products = List<ApparelProductModel>();
    currentProduct = ApparelProductModel.empty();
  }

  static ApparelProductBLoC _getInstance() {
    if (_instance == null) {
      _instance = ApparelProductBLoC._internal();
    }
    return _instance;
  }

  var _controller = StreamController<List<ApparelProductModel>>.broadcast();
  var _detailController = StreamController<ApparelProductModel>();

  Stream<List<ApparelProductModel>> get stream => _controller.stream;

  Stream<ApparelProductModel> get detailStream => _detailController.stream;

  getProduct(String code) {
    _detailController.sink.add(ApparelProductModel.fromJson({
      'approvalStatus': 'APPROVED',
      'code': 'C0001',
      'name': '山本风少女长裙复古气质秋冬流行新款',
      'price': 100.00,
      'suggestedPrice': 99.00,
      'price1': 98.00,
      'price2': 97.00,
      'price3': 96.00,
     /* 'variants':[
        {
          'color':{
            'code':'C01',
            'name':'海军蓝',
            'colorCode':'0066FF',
          },
          'size':{

          }
        }
      ],*/
      'skuID': 'SKU0001',
      'salesVolume': 10,
      'isRecommend': true,
      'brand': '云顶',
      'gramWeight': 1.00,
      'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
      'normal': [
        'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
        'https://node.500px.me/tpl/baijia0103/imgs/shili1.jpg'
      ],
      'detail': [
        'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
        'https://node.500px.me/tpl/baijia0103/imgs/shili1.jpg'
      ],
      'stockLevel': {
        'available': 99,
        'maxPreOrder': 120,
      },
      'attributes': {
        'styles': ['A001', 'A002'],
        'fabricComposition': 'B001',
        'editionType': 'C001',
        'pattern': 'D001',
        'sleeveType': 'E001',
        'sleeveLength': 'F001',
        'decorativePattern': ['G001', 'G002'],
        'popularElements': ['H001', 'H002'],
        'filler': 'J001',
        'thickness': 'K001',
        'season': 'L001',
        'placket': 'M001',
        'taggable':true,
      }
    }));
  }

  filterByStatuses() async {
    //若没有数据则查询
    if (products.isEmpty) {
      // TODO: 分页拿数据，response.data;
      products.addAll(await Future.delayed(const Duration(seconds: 1), () {
        return <ApparelProductModel>[
          ApparelProductModel.fromJson({
            'approvalStatus': 'APPROVED',
            'code': 'C0001',
            'name': '山本风少女长裙复古气质秋冬流行新款',
            'price': 100.00,
            'suggestedPrice': 99,
            'price1': 98,
            'price2': 97,
            'price3': 96,
            'staircasePrices':[
              {
                'minQuantity':50,
                'price':59,
              },
              {
                'minQuantity':100,
                'price':119,
              },
              {
                'minQuantity':200,
                'price':199,
              },
            ],
            'skuID': 'SKU0001',
            'salesVolume': 10,
            'isRecommend': true,
            'brand': '云顶',
            'gramWeight': 1.00,
            'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
            'normal': [
              'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
              'https://node.500px.me/tpl/baijia0103/imgs/shili1.jpg'
            ],
            'detail': [
              'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
              'https://node.500px.me/tpl/baijia0103/imgs/shili1.jpg'
            ],
            'stockLevel': {
              'available': 99,
              'maxPreOrder': 120,
            },

            'attributes': {
              'styles': ['A001', 'A002'],
              'fabricComposition': 'B001',
              'editionType': 'C001',
              'pattern': 'D001',
              'sleeveType': 'E001',
              'sleeveLength': 'F001',
              'decorativePattern': ['G001', 'G002'],
              'popularElements': ['H001', 'H002'],
              'filler': 'J001',
              'taggable':true,
              'thickness': 'K001',
              'season': 'L001',
              'placket': 'M001',
            }
          }),
          ApparelProductModel.fromJson({
            'approvalStatus': 'APPROVED',
            'code': 'C0002',
            'name': '山本风少女长裙复古气质秋冬流行新款',
            'price': 102.00,
            'suggestedPrice': 89,
            'price1': 88,
            'price2': 87,
            'price3': 86,
            'skuID': 'SKU0002',
            'salesVolume': 12,
            'isRecommend': false,
            'brand': '同创',
            'gramWeight': 1.50,
            'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
            'normal': [
              'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
              'https://node.500px.me/tpl/baijia0103/imgs/shili1.jpg'
            ],
            'detail': [
              'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
              'https://node.500px.me/tpl/baijia0103/imgs/shili1.jpg'
            ],
            'stockLevel': {
              'available': 97,
              'maxPreOrder': 122,
            },
            'attributes': {
              'styles': ['A001', 'A002'],
              'fabricComposition': 'B001',
              'editionType': 'C001',
              'pattern': 'D001',
              'sleeveType': 'E001',
              'sleeveLength': 'F001',
              'decorativePattern': ['G001', 'G002'],
              'popularElements': ['H001', 'H002'],
              'filler': 'J001',
              'thickness': 'K001',
              'season': 'L001',
              'taggable':false,
              'placket': 'M001',
            }
          }),
          ApparelProductModel.fromJson({
            'approvalStatus': 'APPROVED',
            'code': 'C0002',
            'name': '山本风少女长裙复古气质秋冬流行新款',
            'price': 102.00,
            'suggestedPrice': 89,
            'price1': 88,
            'price2': 87,
            'price3': 86,
            'skuID': 'SKU0002',
            'salesVolume': 12,
            'isRecommend': false,
            'brand': '同创',
            'gramWeight': 1.50,
            'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
            'stockLevel': {
              'available': 97,
              'maxPreOrder': 122,
            },
            'attributes': {
              'styles': ['A001', 'A002'],
              'fabricComposition': 'B001',
              'editionType': 'C001',
              'pattern': 'D001',
              'sleeveType': 'E001',
              'sleeveLength': 'F001',
              'decorativePattern': ['G001', 'G002'],
              'popularElements': ['H001', 'H002'],
              'filler': 'J001',
              'thickness': 'K001',
              'season': 'L001',
              'placket': 'M001',
            }
          }),
          ApparelProductModel.fromJson({
            'approvalStatus': 'APPROVED',
            'code': 'C0002',
            'name': '山本风少女长裙复古气质秋冬流行新款',
            'price': 102.00,
            'suggestedPrice': 89,
            'price1': 88,
            'price2': 87,
            'price3': 86,
            'skuID': 'SKU0002',
            'salesVolume': 12,
            'isRecommend': false,
            'brand': '同创',
            'gramWeight': 1.50,
            'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
            'stockLevel': {
              'available': 97,
              'maxPreOrder': 122,
            },
            'attributes': {
              'styles': ['A001', 'A002'],
              'fabricComposition': 'B001',
              'editionType': 'C001',
              'pattern': 'D001',
              'sleeveType': 'E001',
              'sleeveLength': 'F001',
              'decorativePattern': ['G001', 'G002'],
              'popularElements': ['H001', 'H002'],
              'filler': 'J001',
              'thickness': 'K001',
              'season': 'L001',
              'placket': 'M001',
            }
          }),
          ApparelProductModel.fromJson({
            'approvalStatus': 'APPROVED',
            'code': 'C0002',
            'name': '山本风少女长裙复古气质秋冬流行新款',
            'price': 102.00,
            'suggestedPrice': 89,
            'price1': 88,
            'price2': 87,
            'price3': 86,
            'skuID': 'SKU0002',
            'salesVolume': 12,
            'isRecommend': false,
            'brand': '同创',
            'gramWeight': 1.50,
            'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
            'stockLevel': {
              'available': 97,
              'maxPreOrder': 122,
            },
            'attributes': {
              'styles': ['A001', 'A002'],
              'fabricComposition': 'B001',
              'editionType': 'C001',
              'pattern': 'D001',
              'sleeveType': 'E001',
              'sleeveLength': 'F001',
              'decorativePattern': ['G001', 'G002'],
              'popularElements': ['H001', 'H002'],
              'filler': 'J001',
              'thickness': 'K001',
              'season': 'L001',
              'placket': 'M001',
            }
          }),
        ];
      }));
    }
    _controller.sink.add(products);
  }

  loadingMoreByStatuses() async {
    //模拟数据到底
    if (products.length < 6) {
      products.add(await Future.delayed(const Duration(seconds: 1), () {
        return ApparelProductModel.fromJson({
          'approvalStatus': 'APPROVED',
          'code': 'C0002',
          'name': '山本风少女长裙复古气质秋冬流行新款',
          'price': 102.00,
          'suggestedPrice': 89,
          'price1': 88,
          'price2': 87,
          'price3': 86,
          'skuID': 'SKU0002',
          'salesVolume': 12,
          'isRecommend': false,
          'brand': '同创',
          'gramWeight': 1.50,
          'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
          'stockLevel': {
            'available': 97,
            'maxPreOrder': 122,
          },
          'attributes': {
            'styles': ['A001', 'A002'],
            'fabricComposition': 'B001',
            'editionType': 'C001',
            'pattern': 'D001',
            'sleeveType': 'E001',
            'sleeveLength': 'F001',
            'decorativePattern': ['G001', 'G002'],
            'popularElements': ['H001', 'H002'],
            'filler': 'J001',
            'thickness': 'K001',
            'season': 'L001',
            'placket': 'M001',
          }
        });
      }));
    } else {
      //通知显示已经到底部
      _bottomController.sink.add(true);
    }
    _loadingController.sink.add(false);
    _controller.sink.add(products);
  }

  //下拉刷新
  Future refreshData() async {
    products.clear();
    products.add(await Future.delayed(const Duration(seconds: 1), () {
      return ApparelProductModel.fromJson({
        'approvalStatus': 'APPROVED',
        'code': 'C0002',
        'name': '山本风少女长裙复古气质秋冬流行新款',
        'price': 102.00,
        'suggestedPrice': 89,
        'price1': 88,
        'price2': 87,
        'price3': 86,
        'skuID': 'SKU0002',
        'salesVolume': 12,
        'isRecommend': false,
        'brand': '同创',
        'gramWeight': 1.50,
        'thumbnail': 'http://img.alicdn.com/bao/uploaded/O1CN01lBdn6U1X6KmbjwLmM_!!595412874.jpg_80x80.jpg',
        'stockLevel': {
          'available': 97,
          'maxPreOrder': 122,
        },
        'attributes': {
          'styles': ['A001', 'A002'],
          'fabricComposition': 'B001',
          'editionType': 'C001',
          'pattern': 'D001',
          'sleeveType': 'E001',
          'sleeveLength': 'F001',
          'decorativePattern': ['G001', 'G002'],
          'popularElements': ['H001', 'H002'],
          'filler': 'J001',
          'thickness': 'K001',
          'season': 'L001',
          'placket': 'M001',
          'taggable':true,
        }
      });
    }));
    _controller.sink.add(products);
  }

  //页面控制

  var _loadingController = StreamController<bool>.broadcast();
  var _bottomController = StreamController<bool>.broadcast();
  var _toTopBtnController = StreamController<bool>.broadcast();
  var _returnToTopController = StreamController<bool>.broadcast();

  Stream<bool> get loadingStream => _loadingController.stream;

  Stream<bool> get bottomStream => _bottomController.stream;

  Stream<bool> get toTopBtnStream => _toTopBtnController.stream;

  Stream<bool> get returnToTopStream => _returnToTopController.stream;

  loadingStart() async {
    _loadingController.sink.add(true);
  }

  loadingEnd() async {
    _loadingController.sink.add(false);
  }

  showToTopBtn() async {
    _toTopBtnController.sink.add(true);
  }

  hideToTopBtn() async {
    _toTopBtnController.sink.add(false);
  }

  returnToTop() async {
    _returnToTopController.sink.add(true);
  }

  dispose() {
    _controller.close();
    _detailController.close();
    _loadingController.close();
    _bottomController.close();
    _toTopBtnController.close();
    _returnToTopController.close();
  }
}
