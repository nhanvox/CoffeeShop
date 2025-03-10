import 'package:coffeeshop/page/login/view/components/quicksand.dart';
import 'package:coffeeshop/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final double iconSize;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeOption({
    super.key,
    required this.label,
    required this.icon,
    required this.iconSize,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: 60.0, // Đặt kích thước cố định cho hình tròn
            height: 60.0, // Đặt kích thước cố định cho hình tròn
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? const Color(0xFFFF725E)
                  : const Color(0xFFFF725E).withOpacity(0.2),
            ),
            child: Center(
              child: Icon(
                icon,
                size: iconSize,
                color: isSelected ? Colors.white : const Color(0xFFFF725E),
              ),
            ),
          ),
          TextQuicksand(
            label,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
