import 'package:flutter/material.dart';

import '../helpers/app_colors.dart';

class MyListTile extends StatelessWidget {
 Widget? title,subtitle,trailing,leading;
 void Function()? onTap;
 Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      tileColor: bgColor,
      trailing: trailing,
      leading: leading,
      onTap: onTap,
      contentPadding: EdgeInsets.only(right: 0),
    );
  }

 MyListTile({
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    this.bgColor = AppColors.bgAppColor,
  });
}
