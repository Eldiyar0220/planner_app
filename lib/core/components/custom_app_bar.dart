import 'package:flutter/material.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.isCanPop = true,
  });
  final String title;
  final bool isCanPop;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: isCanPop
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              )
            : const SizedBox.shrink(),
        elevation: 0,
        backgroundColor: AppColors.color38B6FFBLue,
      ),
    );
  }
}
