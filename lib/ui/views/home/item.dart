import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mim_generator/models/meme.dart';
import 'package:mim_generator/styles.dart';

class HomeItem extends StatelessWidget {
  final Meme data;
  Function()? onTap;

  HomeItem(
    this.data, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.normal,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: CachedNetworkImage(
            imageUrl: data.url,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
