import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mim_generator/controllers/editor_controller.dart';
import 'package:mim_generator/models/editor_item.dart';
import 'package:mim_generator/styles.dart';
import 'package:mim_generator/ui/components/draggable.dart';
import 'package:mim_generator/utils/toast.dart';

class EditorItemWidget extends ConsumerStatefulWidget {
  EditorItem data;

  EditorItemWidget(this.data, {super.key});

  @override
  ConsumerState<EditorItemWidget> createState() => _EditorItemWidgetState();
}

class _EditorItemWidgetState extends ConsumerState<EditorItemWidget> {
  final _initialStickerScale = 5.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = ref.watch(editorSelectedItemProvider);

    return DraggableResizable(
      key: Key('editorItem_${widget.data.type}_${widget.data.id}'),
      canTransform: selectedItem == widget.data.id,
      onEdit: () {
        toastInfo("TODO EDIT ${widget.data.id}");
      },
      onDelete: () async {
        ref.read(editorItemsProvider.notifier).update((state) {
          var newState = state.where((element) => element.id != widget.data.id);

          return newState.toList();
        });
      },
      size: Size(64 * _initialStickerScale / 3, 64 * _initialStickerScale / 3),
      constraints: BoxConstraints.tight(
        Size(
          64 * _initialStickerScale / 3,
          64 * _initialStickerScale / 3,
        ),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          ref.read(editorSelectedItemProvider.notifier).update((state) => widget.data.id);
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: widget.data.type == 'text'
              ? FittedBox(
                  child: Stack(
                    children: [
                      Text(
                        widget.data.data,
                        style: AppFonts.secondary(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.black,
                        ),
                      ),
                      Text(
                        widget.data.data,
                        style: AppFonts.secondary(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Image.file(
                  File(widget.data.data),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
