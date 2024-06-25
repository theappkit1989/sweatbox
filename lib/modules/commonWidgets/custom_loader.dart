import 'package:flutter/material.dart';
import '../../../../themes/colors/color_light.dart';

class CustomLoader extends StatelessWidget {
  final bool isShowOnScreen;
  final bool isShowLoadingText;

  const CustomLoader({
    Key? key,
    this.isShowOnScreen = true,
    this.isShowLoadingText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: isShowLoadingText ? 0 : 10,
          ),
          Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              backgroundColor: ColorLight.loaderBgColor,
              valueColor: AlwaysStoppedAnimation<Color>(ColorLight.textColorBlue),
            ),
          ),
          SizedBox(
            height: isShowLoadingText ? 10 : 0,
          ),
        ],
      ),
    );
  }
}
