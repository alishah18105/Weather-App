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

class CustomInformationContainer extends StatelessWidget {
  final IconData customIcon;
  final String customInformation;
  final String customInfoValue;

  const CustomInformationContainer({super.key, required this.customIcon, required this.customInformation, required this.customInfoValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 100,
            width: 170,
            child: Card(
              color: Color(0xFF6A4C93),
              elevation: 5,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(customIcon, color: AppColors.white, size: 30,),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customInformation, style: TextStyle(color: AppColors.lightgrey, fontSize: 15),),
                      SizedBox(height: 5,),
                      Text(customInfoValue, style: TextStyle(color: AppColors.white, fontSize: 18),),

                    ],
                  )
                ],    
              )
            ),
          );
  }
}