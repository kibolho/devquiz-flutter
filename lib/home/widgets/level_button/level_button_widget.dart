import 'package:devquiz/shared/models/quiz_model.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:devquiz/core/app_colors.dart';

class LevelButtonWidget extends StatelessWidget {
  final Level optionLevel;
  final bool isSelected;
  final ValueChanged<Level> onTap;

  LevelButtonWidget({
    Key? key,
    required this.optionLevel,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final config = {
    Level.all: {
      'label': "All",
      'color': AppColors.white,
      'borderColor': AppColors.black,
      'fontColor': AppColors.black,
    },
    Level.easy: {
      'label': 'Easy',
      'color': AppColors.levelButtonEasy,
      'borderColor': AppColors.levelButtonBorderEasy,
      'fontColor': AppColors.levelButtonTextEasy,
    },
    Level.middle: {
      'label': 'Middle',
      'color': AppColors.levelButtonMiddle,
      'borderColor': AppColors.levelButtonBorderMiddle,
      'fontColor': AppColors.levelButtonTextMiddle,
    },
    Level.hard: {
      'label': 'Hard',
      'color': AppColors.levelButtonHard,
      'borderColor': AppColors.levelButtonBorderHard,
      'fontColor': AppColors.levelButtonTextHard,
    },
    Level.expert: {
      'label': 'Expert',
      'color': AppColors.levelButtonExpert,
      'borderColor': AppColors.levelButtonBorderExpert,
      'fontColor': AppColors.levelButtonTextExpert,
    },
  };
  String get label => config[optionLevel]!['label']! as String;
  Color get color => config[optionLevel]!['color']! as Color;
  Color get borderColor => config[optionLevel]!['borderColor']! as Color;
  Color get fontColor => config[optionLevel]!['fontColor']! as Color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap(optionLevel);
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            border: isSelected
                ? Border.fromBorderSide(BorderSide(color: borderColor))
                : null,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
            child: Text(
              label,
              style: GoogleFonts.notoSans(
                color: fontColor,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ));
  }
}
