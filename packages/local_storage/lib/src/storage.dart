import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class LocalStorage {
  late final Box box;

  static LocalStorage? _instance;

  static Future<LocalStorage> init([String? id]) async {
    if (_instance != null) return _instance!;
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    const FlutterSecureStorage secureStorage = FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    String? keyEncrpt = await secureStorage.read(key: id ?? 'encrpt');
    keyEncrpt ??= const Uuid().v4();
    secureStorage.write(key: id ?? 'encrpt', value: keyEncrpt);

    String? encrpt = await secureStorage.read(key: keyEncrpt);

    if (encrpt == null) {
      final String key = base64UrlEncode(Hive.generateSecureKey());
      await secureStorage.write(key: keyEncrpt, value: key);
      encrpt = key;
    }

    final encryptionKey = base64Url.decode(encrpt);

    String? boxName = await secureStorage.read(key: id ?? 'BoxName');
    boxName ??= const Uuid().v4();
    secureStorage.write(key: id ?? 'BoxName', value: boxName);

    final box = await Hive.openBox(id ?? boxName,
        encryptionCipher: HiveAesCipher(encryptionKey));
    _instance = LocalStorage._internal(box);
    return _instance!;
  }

  LocalStorage._internal(this.box);

  static void put(dynamic key, dynamic value) {
    try {
      _instance!.box.put(key.toString(), json.encode(value.toJson()));
    } catch (_) {
      _instance!.box.put(key.toString(), value);
    }
  }

  static void putList(dynamic key, List value) {
    try {
      _instance!.box.put(
          key.toString(), json.encode(value.map((e) => e.toJson()).toList()));
    } catch (_) {
      _instance!.box.put(key.toString(), value);
    }
  }

  static T? get<T>(dynamic key,
      [T Function(Map<String, dynamic> data)? decoder]) {
    try {
      final data = _instance!.box.get(key.toString());

      if (decoder != null && data != null) {
        return decoder(json.decode(data));
      } else {
        return data;
      }
    } catch (_) {
      return null;
    }
  }

  static List<T>? getList<T>(dynamic key,
      [T Function(Map<String, dynamic> data)? decoder]) {
    try {
      final data = _instance!.box.get(key.toString());

      if (decoder != null && data != null) {
        return (json.decode(data) as List).map((e) => decoder(e)).toList();
      } else {
        return data;
      }
    } catch (_) {
      return null;
    }
  }

  static void delete(dynamic key) {
    _instance!.box.delete(key.toString());
  }
}
