import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TCardText extends StatefulWidget {
  const TCardText({super.key});

  @override
  State<TCardText> createState() => _TCardTextState();
}

class _TCardTextState extends State<TCardText> {
  @override
  Widget build(BuildContext context) {
    //获取主题
    final theme = Theme.of(context);
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(children: [
            Positioned.fill(
              child: Image.asset(
                'assets/img181.webp',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 10,
              child: Text(
                '你的文字',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
