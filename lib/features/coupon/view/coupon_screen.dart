import 'package:flutter/material.dart';
import 'package:ecommerce/localization/language_constrants.dart';
import 'package:ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:ecommerce/features/coupon/provider/coupon_provider.dart';
import 'package:ecommerce/utill/dimensions.dart';
import 'package:ecommerce/utill/images.dart';
import 'package:ecommerce/basewidget/custom_app_bar.dart';
import 'package:ecommerce/basewidget/no_internet_screen.dart';
import 'package:ecommerce/basewidget/not_loggedin_widget.dart';
import 'package:ecommerce/features/coupon/widget/coupon_item.dart';
import 'package:ecommerce/features/order/widget/order_shimmer.dart';
import 'package:provider/provider.dart';

class CouponList extends StatefulWidget {
  const CouponList({super.key});

  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  @override
  void initState() {
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
      Provider.of<CouponProvider>(context, listen: false).getCouponList(context, 1);

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('coupons', context)),
      body: Provider.of<AuthController>(context, listen: false).isLoggedIn()?

      Consumer<CouponProvider>(
          builder: (context, couponProvider,_) {
            return couponProvider.couponList != null? couponProvider.couponList!.isNotEmpty?
            Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: couponProvider.couponList!.length,
                  itemBuilder: (context, index){
                    return CouponItem(coupons: couponProvider.couponList![index]);
                  }),
            ) : const NoInternetOrDataScreen(isNoInternet: false,
              icon: Images.noCoupon, message: 'no_coupon_available') : const OrderShimmer();
          }
      ): const NotLoggedInWidget(),
    );
  }
}