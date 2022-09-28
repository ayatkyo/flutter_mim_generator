import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mim_generator/controllers/editor_controller.dart';
import 'package:mim_generator/models/editor_item.dart';
import 'package:mim_generator/models/meme.dart';
import 'package:mim_generator/styles.dart';
import 'package:mim_generator/ui/components/button.dart';
import 'package:mim_generator/ui/views/editor/item.dart';

class EditorPage extends ConsumerWidget {
  Meme data;

  EditorPage(this.data, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(editorController.notifier);
    final itemList = ref.watch(editorItemsProvider);
    final canGenerate = ref.watch(editorCanGenerate);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "MimGenerator",
              style: AppFonts.primary(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Text(
              data.name,
              style: AppFonts.secondary(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: RepaintBoundary(
                  key: ref.read(editorKeyProvider),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: data.url,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.contain,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            ref.read(editorSelectedItemProvider.notifier).update((state) => null);
                          },
                        ),
                      ),
                      for (EditorItem item in itemList)
                        EditorItemWidget(
                          item,
                          onEdit: () => controller.editClick(item),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            color: Colors.white.withOpacity(0.1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Button(
                        text: "ADD LOGO",
                        icon: Icons.image,
                        onPressed: () => controller.addLogoClick(),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Button(
                        text: "ADD TEXT",
                        icon: Icons.text_fields_rounded,
                        onPressed: () => controller.addTextClick(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (canGenerate)
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
                top: 8,
              ),
              color: Colors.white.withOpacity(0.15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Button(
                          color: Colors.green,
                          textColor: Colors.white,
                          text: "SIMPAN",
                          onPressed: () => controller.saveClick(),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Button(
                          text: "SHARE",
                          color: Colors.amber,
                          textColor: Colors.white,
                          onPressed: () => controller.shareClick(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
