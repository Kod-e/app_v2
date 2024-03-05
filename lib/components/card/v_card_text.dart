import 'package:flutter/material.dart';

class VCardText extends StatefulWidget {
  const VCardText({super.key});

  @override
  State<VCardText> createState() => _VCardTextState();
}

class _VCardTextState extends State<VCardText> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
    //获取主题
    final theme = Theme.of(context);
    
    //标题的style
    final titleColor = theme.colorScheme.onSecondaryContainer.withOpacity(0.9);
    final descriptionColor = theme.colorScheme.onSecondaryContainer.withOpacity(0.7);
    //自适应大小
    var titleStyle = theme.textTheme.bodySmall!
        .copyWith(color: titleColor);
    var descriptionStyle = theme.textTheme.labelSmall!
        .copyWith(color: descriptionColor);
    double paddingHeight = 5;
    double sizeboxHeight = 1;
    if (constraints.maxWidth > 220) {
      titleStyle = theme.textTheme.titleMedium!
          .copyWith(color: titleColor);
      descriptionStyle = theme.textTheme.bodyMedium!
          .copyWith(color: descriptionColor);
      paddingHeight = 8;
      sizeboxHeight = 3;
    }else if (constraints.maxWidth > 200) {
      titleStyle = theme.textTheme.titleMedium!
          .copyWith(color: titleColor);
      descriptionStyle = theme.textTheme.bodySmall!
          .copyWith(color: descriptionColor);
      paddingHeight = 8;
      sizeboxHeight = 3;
    }else if (constraints.maxWidth > 180) {
      titleStyle = theme.textTheme.bodyMedium!
          .copyWith(color: titleColor);
      descriptionStyle = theme.textTheme.labelMedium!
          .copyWith(color: descriptionColor);
      paddingHeight = 5;
      sizeboxHeight = 3;
    } 
      return Card(
        color: theme.colorScheme.secondaryContainer,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/img181.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingHeight),
              child: Column(
                children: [
                  SizedBox(
                    height: sizeboxHeight,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "这是标题这是标题",
                      style: titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: sizeboxHeight,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "这是描述这是描述 这是描述这是描述 这是描述这是描述",
                      style: descriptionStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
