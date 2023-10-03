import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_text.dart';
import 'app_colors.dart';

class ShowLoading extends StatelessWidget {
  final bool show;
  const ShowLoading({
    Key? key,
    this.show = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        App_Text(
          data: show ? 'اكتب ما تريد البحث عنه' : "الرجاء الإنتظار ",
          color: Get.isDarkMode ? AppColors.kWhite : AppColors.kbiColor,
        ),
        const SizedBox(height: 15),
        Center(
          child: CircularProgressIndicator(
            color: Get.isDarkMode ? AppColors.kPr2Color : AppColors.kScColor,
          ),
        ),
      ],
    );
  }
}
