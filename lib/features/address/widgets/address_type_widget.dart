import 'package:flutter/material.dart';
import 'package:ecommerce/features/address/domain/model/address_model.dart';
import 'package:ecommerce/utill/color_resources.dart';
import 'package:ecommerce/utill/custom_themes.dart';
import 'package:ecommerce/utill/images.dart';
class AddressListPage extends StatelessWidget {
  final AddressModel? address;
  const AddressListPage({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(address!.addressType == 'Home' ? Images.homeImage
          : address!.addressType == 'Workplace' ? Images.bag : Images.moreImage,
        color: ColorResources.getSellerTxt(context), height: 30, width: 30),
      title: Text(address!.address!, style: titilliumRegular),
    );
  }
}
