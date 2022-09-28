import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mim_generator/models/editor_item.dart';
import 'package:mim_generator/router.dart';
import 'package:mim_generator/ui/views/editor/modal_text.dart';
import 'package:mim_generator/utils/toast.dart';
import 'package:one_context/one_context.dart';
import 'package:path_provider/path_provider.dart';

final editorController = StateNotifierProvider.autoDispose<_Controller, bool>((ref) => _Controller(ref.read));
final editorItemsProvider = StateProvider.autoDispose<List<EditorItem>>((ref) => []);
final editorSelectedItemProvider = StateProvider.autoDispose<String?>((ref) => null);
final editorKeyProvider = Provider<GlobalKey>((ref) => GlobalKey());

final editorCanGenerate = Provider.autoDispose<bool>((ref) {
  final items = ref.watch(editorItemsProvider);
  bool hasText = items.where((element) => element.type == 'text').isNotEmpty;
  bool hasImage = items.where((element) => element.type == 'image').isNotEmpty;
  return hasText && hasImage;
});

class _Controller extends StateNotifier<bool> {
  final Reader read;

  ImagePicker imagePicker = ImagePicker();

  _Controller(this.read) : super(false);

  addTextClick() async {
    String? newText = await showEditorTextModal(context: OneContext.instance.context!);
    if (newText != null) {
      toastSuccess("Text berhasil ditambahkan");
      read(editorItemsProvider.notifier).update((state) {
        return [
          ...state,
          EditorItem(DateTime.now().microsecond.toString(), "text", newText),
        ];
      });
    }
  }

  addLogoClick() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      read(editorItemsProvider.notifier).update((state) {
        return [
          ...state,
          EditorItem(DateTime.now().microsecond.toString(), "image", image.path),
        ];
      });
    }
  }

  Future<String?> generateMeme() async {
    try {
      final editor = read(editorKeyProvider).currentContext?.findRenderObject() as RenderRepaintBoundary?;
      final image = await editor?.toImage();
      final imageData = await image?.toByteData(format: ImageByteFormat.png);
      final imageBytes = imageData!.buffer.asUint8List();

      //  Create temp file
      final tempDir = await getTemporaryDirectory();
      final savePath = "${tempDir.path}/meme_temp.png";
      File file = await File(savePath).create();
      await file.writeAsBytes(imageBytes);

      return savePath;
    } catch (e) {
      return null;
    }
  }

  saveClick() async {
    String? newMeme = await generateMeme();

    if (newMeme == null) {
      toastError("Gagal menyimpan gambar");
      return;
    }

    //  Save meme ke gallery
    await ImageGallerySaver.saveFile(newMeme);
    toastSuccess("Gambar berhasil disimpan");
  }

  shareClick() async {
    String? newMeme = await generateMeme();

    if (newMeme == null) {
      toastError("Gagal menyiapkan gambar");
      return;
    }

    read(routerProvider).pushNamed(Routes.share, extra: newMeme);
  }
}
