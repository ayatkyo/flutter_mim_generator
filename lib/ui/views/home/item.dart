import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mim_generator/models/meme.dart';
import 'package:mim_generator/router.dart';
import 'package:mim_generator/styles.dart';

class HomeItem extends StatelessWidget {
  final Meme data;

  HomeItem(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.normal,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => context.pushNamed(Routes.editor, extra: data),
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
