import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mim_generator/controllers/home_controller.dart';
import 'package:mim_generator/styles.dart';
import 'package:mim_generator/ui/views/home/item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(homeController.notifier);
    final viewModel = ref.watch(homeController);

    return Scaffold(
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
              viewModel.whenData((value) => "Ada ${value.length} memes").value ?? "Sedang memuat",
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.load();
        },
        child: Container(
          child: viewModel.when(
            data: (data) {
              return SingleChildScrollView(
                physics: AppBounceScrollPhysic,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return HomeItem(data[index]);
                      },
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: AppFonts.secondary(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
