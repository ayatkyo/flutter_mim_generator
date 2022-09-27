import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mim_generator/models/meme.dart';
import 'package:mim_generator/services/imgflip_service.dart';

final homeController = StateNotifierProvider.autoDispose<_Controller, AsyncValue<List<Meme>>>((ref) {
  return _Controller(ref.read);
});

class _Controller extends StateNotifier<AsyncValue<List<Meme>>> {
  final Reader read;

  _Controller(this.read) : super(const AsyncValue.loading()) {
    load();
  }

  load() async {
    try {
      Response res = await read(imgflipApiProvider).get("/get_memes");
      if (res.data['data'] != null && res.data['data']['memes'] != null) {
        state = AsyncValue.data(
          List<Meme>.from(
            res.data['data']['memes'].map((item) => Meme.fromMap(item))
          )
        );
      } else {
        throw Exception("Gagal parse data memes");
      }
    } catch (e) {
      print(e);
    }
  }
}
