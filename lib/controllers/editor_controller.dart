import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mim_generator/models/editor_item.dart';
import 'package:mim_generator/ui/views/editor/modal_text.dart';
import 'package:mim_generator/utils/toast.dart';
import 'package:one_context/one_context.dart';

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

  saveClick() async {
    try {
      final imgBoundary = read(editorKeyProvider).currentContext?.findRenderObject() as RenderRepaintBoundary?;
      final image = await imgBoundary?.toImage();
      final imageData = await image?.toByteData(format: ImageByteFormat.png);

      await ImageGallerySaver.saveImage(imageData!.buffer.asUint8List(), quality: 100);
      
      toastSuccess("Gambar berhasil disimpan");
    } catch (e) {
      toastError(e.toString());
    }
  }

  shareClick() {
    toastInfo("TODO: Share");
  }
}
