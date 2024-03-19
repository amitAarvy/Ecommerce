import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/features/loyaltyPoint/domain/model/loyalty_point_model.dart';
import 'package:ecommerce/features/loyaltyPoint/provider/loyalty_point_provider.dart';
import 'package:ecommerce/utill/dimensions.dart';
import 'package:ecommerce/utill/images.dart';
import 'package:ecommerce/basewidget/no_internet_screen.dart';
import 'package:ecommerce/basewidget/product_shimmer.dart';
import 'package:ecommerce/features/loyaltyPoint/widget/loyalty_point_widget.dart';
import 'package:provider/provider.dart';

class LoyaltyPointListView extends StatelessWidget {
  final ScrollController? scrollController;
  const LoyaltyPointListView({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if(scrollController!.position.maxScrollExtent == scrollController!.position.pixels
          && Provider.of<LoyaltyPointProvider>(context, listen: false).loyaltyPointList.isNotEmpty
          && !Provider.of<LoyaltyPointProvider>(context, listen: false).isLoading) {
        int? pageSize;
        pageSize = Provider.of<LoyaltyPointProvider>(context, listen: false).loyaltyPointPageSize;

        if(offset < pageSize!) {
          offset++;
          if (kDebugMode) {
            print('end of the page');
          }
          Provider.of<LoyaltyPointProvider>(context, listen: false).showBottomLoader();
          Provider.of<LoyaltyPointProvider>(context, listen: false).getLoyaltyPointList(context, offset);
        }
      }

    });

    return Consumer<LoyaltyPointProvider>(
      builder: (context, loyaltyProvider, child) {
        List<LoyaltyPointList> loyaltyPointList;
        loyaltyPointList = loyaltyProvider.loyaltyPointList;

        return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

          !loyaltyProvider.firstLoading ? (loyaltyPointList.isNotEmpty) ?
          Padding(padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: loyaltyPointList.length,
                itemBuilder: (ctx,index){
                  return LoyaltyPointWidget(loyaltyPointModel: loyaltyPointList[index], index: index,length: loyaltyPointList.length);
                })):

          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
            child: const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noTransaction,
              message: 'no_transaction_history')) :

          ProductShimmer(isHomePage: true ,isEnabled: loyaltyProvider.firstLoading),
          loyaltyProvider.isLoading ? Center(child: Padding(padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))) :
          const SizedBox.shrink(),

        ]);
      },
    );
  }
}
