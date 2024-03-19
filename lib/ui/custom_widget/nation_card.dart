import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:znations/data/model/nation.dart';
import 'package:znations/ui/detail/detail_page.dart';

class NationCard extends StatelessWidget {
  Nation nation;
  NationCard({super.key,required this.nation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .push(
            MaterialPageRoute(
              builder: (context) => DetailPage(
                nation: nation
              ),
            ),
          );
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: SizedBox.fromSize(
                  size: const Size.fromRadius(32),
                  child: CachedNetworkImage(
                    imageUrl: nation.imgUrl!,
                    placeholder: (context, url) => Icon(Icons.flag_circle),
                    errorWidget: (context, url, error) => Icon(Icons.flag_circle),
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(nation.name.toString()),
                subtitle: Text(nation.membershipWithinUN.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}