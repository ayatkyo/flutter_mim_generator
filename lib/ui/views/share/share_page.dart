import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mim_generator/controllers/share_controller.dart';
import 'package:mim_generator/styles.dart';
import 'package:mim_generator/ui/components/button.dart';

class SharePage extends ConsumerWidget {
  String image;

  SharePage(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(shareController.notifier);

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
              "Share mim kamu",
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
                child: Image.file(
                  File(image),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 20,
            ),
            width: double.infinity,
            child: Column(
              children: [
                Button(
                  text: "Share to FB",
                  color: Color(0xFF395693),
                  textColor: Colors.white,
                  onPressed: () => controller.shareFB(image),
                ),
                const SizedBox(height: 10,),
                Button(
                  text: "Share to Twitter",
                  color: Color(0xFF1c9cea),
                  textColor: Colors.white,
                  onPressed: () => controller.shareTwitter(image),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
