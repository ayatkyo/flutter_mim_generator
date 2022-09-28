import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

final shareController = StateNotifierProvider<_Controller, bool>((ref) => _Controller(ref.read));

class _Controller extends StateNotifier<bool> {
  final Reader read;

  _Controller(this.read) : super(false);

  shareFB(String image) {
    Share.shareFiles([image]);
  }

  shareTwitter(String image) {
    Share.shareFiles([image]);
  }
}
