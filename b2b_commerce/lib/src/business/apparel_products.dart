import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:widgets/widgets.dart';

import '../common/app_routes.dart';
import 'apparel_product_list.dart';
import 'products/apparel_product_form.dart';
import 'search/apparel_product_search.dart';

class ApparelProductsPage extends StatelessWidget {
//  final List<ApparelProductModel> items = <ApparelProductModel>[];

  @override
  Widget build(BuildContext context) {
//    List<ApparelProductItem> _items = items.map((item) {
//      return ApparelProductItem(item);
//    }).toList();

    return BLoCProvider<ApparelProductBLoC>(
      bloc: ApparelProductBLoC.instance,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('商品管理'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: ApparelProductSearchDelegate(),
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Menu('', <MenuItem>[
                MenuItem(
                  Icons.shopping_basket,
                  '下架商品',
                  AppRoutes.ROUTE_PRODUCTS_OFF_THE_SHELF,
                )
              ]),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ApparelProductList(),
//                ListView.builder(
//                  shrinkWrap: true,
//                  itemCount: _items.length,
//                  itemBuilder: (context, index) {
//                    return _items[index];
//                  },
//                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApparelProductFormPage()),
            );
          },
        ),
      ),
    );
  }
}
