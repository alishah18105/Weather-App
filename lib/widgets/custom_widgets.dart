import 'package:flutter/material.dart';
import 'package:weather_app/utilis/app_colors.dart';

class AddtionalInformationContainer extends StatelessWidget {
  final IconData customIcon;
  final String customText;
  final String customResult;
  const AddtionalInformationContainer({super.key, required this.customIcon, required this.customText, required this.customResult});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
             // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                Icon(customIcon, color: AppColors.white,),
                SizedBox(height: 3,),
                Text(customText, style: TextStyle(color: AppColors.white,),),
                SizedBox(height: 3,),
                Text(customResult, style: TextStyle(color: AppColors.white,),),
              ],
            ),
          ),
    );
  }
}