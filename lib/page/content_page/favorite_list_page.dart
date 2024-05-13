import 'package:app_v2/model/favoritelist.dart';
import 'package:flutter/material.dart';


class FavoriteListPage extends StatefulWidget {
  final FavoriteList favoriteList;
  const FavoriteListPage({Key? key, required this.favoriteList}) : super(key: key);

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant,
      appBar: AppBar(
        title: Text(this.widget.favoriteList.name!,style: theme.textTheme.titleMedium,),
        foregroundColor: colorScheme.secondary,
      ),
      body: Center(
        child: Column(
          children: [
            Text(this.widget.favoriteList.name!),
          ],
        ),
      ),
    );
  }
}