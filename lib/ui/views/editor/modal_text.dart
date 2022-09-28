import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mim_generator/styles.dart';
import 'package:mim_generator/ui/components/button.dart';
import 'package:mim_generator/ui/components/form_group.dart';
import 'package:one_context/one_context.dart';

class EditorTextModal extends HookConsumerWidget {
  const EditorTextModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = useTextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.normal,
      ),
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 230,
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Text",
                    style: AppFonts.primary(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Tambahkan tulisan ke gambar",
                    style: AppFonts.secondary(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormGroup(
                      label: "Text",
                      placeholder: "Masukkan text",
                      ctrl: input,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.05),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Button(
                      text: "BATAL",
                      onPressed: () => OneContext().popDialog(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Button(
                      text: "SIMPAN",
                      color: AppColors.primary,
                      textColor: Colors.white,
                      onPressed: () {
                        OneContext().popDialog(input.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<T> showEditorTextModal<T>({
  required BuildContext context,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const EditorTextModal(),
  );
}
