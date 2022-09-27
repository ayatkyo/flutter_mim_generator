import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

toastSuccess(String pesan, {bool isShort = false}) {
  BotToast.showText(
    text: pesan,
    contentColor: Colors.greenAccent[400]!,
    textStyle: const TextStyle(
      color: Colors.white,
    ),
    duration: Duration(seconds: isShort ? 2 : 3),
    contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 7),
  );
}

toastError(String pesan, {bool isShort = false}) {
  BotToast.showText(
    text: pesan,
    contentColor: Colors.red[400]!,
    textStyle: const TextStyle(
      color: Colors.white,
    ),
    duration: Duration(seconds: isShort ? 2 : 3),
    contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 7),
  );
}

toastWarn(String pesan, {bool isShort = false}) {
  BotToast.showText(
    text: pesan,
    contentColor: Colors.amber[700]!,
    textStyle: const TextStyle(
      color: Colors.white,
    ),
    duration: Duration(seconds: isShort ? 2 : 3),
    contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 7),
  );
}

toastInfo(String pesan, {bool isShort = false}) {
  BotToast.showText(
    text: pesan,
    contentColor: Colors.blue[600]!,
    textStyle: const TextStyle(
      color: Colors.white,
    ),
    duration: Duration(seconds: isShort ? 2 : 3),
    contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 7),
  );
}
