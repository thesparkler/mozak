import 'package:flutter/material.dart';
import 'package:mozak/constants/AppColors.dart';
import 'package:mozak/utils/app_tools.dart';

class CustomLinearProgress extends StatefulWidget {
  var progress;

  CustomLinearProgress({Key? key, this.progress}) : super(key: key);

  @override
  State<CustomLinearProgress> createState() => _CustomLinearProgressState();
}

class _CustomLinearProgressState extends State<CustomLinearProgress> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // outer container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: hexToColor(AppColors.progressOuterContainerColor),
            ),
            width: MediaQuery.of(context).size.width,
            height: 12,
          ),
          // actual progress bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: hexToColor(AppColors.orangeAccent),
            ),
            width: (MediaQuery.of(context).size.width - 36) * widget.progress,
            height: 12,
          ),
        ],
      ),
    );
  }
}
