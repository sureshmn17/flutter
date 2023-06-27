import 'package:flutter/material.dart';
import 'package:flutter_mvvm_code/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm_code/presentation/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreenTop extends StatelessWidget {
  const LoginScreenTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppHeight.h200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(AppPadding.p16, 0, 0, 0),
                child: Align(
                 alignment:Alignment.bottomLeft,
                 child:SizedBox(
                   child: Image.asset(ImageAssets.logo),
                 ),
                ),
              ),
              Container(
                child: Align(
                  alignment:Alignment.topRight,
                  child: SvgPicture.asset(ImageAssets.logintop),

                ),
              ),


            ],
          ),
        )
      ],
    );
  }
}
