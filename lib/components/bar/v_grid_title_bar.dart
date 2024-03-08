import 'package:flutter/material.dart';
import 'package:app_v2/components/grid/v_grid_text.dart';

class VGridTitleBar extends StatefulWidget {
  const VGridTitleBar({super.key});

  @override
  State<VGridTitleBar> createState() => _VGridTitleBarState();
}

class _VGridTitleBarState extends State<VGridTitleBar> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        child: ListTile(
          trailing: Icon(Icons.arrow_circle_right_rounded),
          title: Text('前往作者'),
          onTap: () {
            print('前往作者');
          },
        ),
      ),
    );
  }
}

// return LayoutBuilder(
//       builder: (context, constraints) {
//         int axisCount = 1;
//         //通过不同的大小设定不同的行数
//         if (constraints.maxWidth >= 900) {
//           axisCount = 5;
//         } else if (constraints.maxWidth >= 550) {
//           axisCount = 3;
//         } else if (constraints.maxWidth >= 300) {
//           axisCount = 2;
//         }
//         return SliverList(
//           delegate: SliverChildListDelegate(
//             [
//               SliverToBoxAdapter(
//                 child: Card(
//                   child: ListTile(
//                     trailing: Icon(Icons.arrow_circle_right_rounded),
//                     title: Text('前往作者'),
//                     onTap: () {
//                       print('前往作者');
//                     },
//                   ),
//                 ),
//               ),
//               VGridText(axisCount: axisCount),
//             ],
//           ),
//         );
//       }
//     );