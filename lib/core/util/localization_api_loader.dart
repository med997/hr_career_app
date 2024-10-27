
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../error/exceptions.dart';

class LocalizationApiLoader extends AssetLoader {
  final SupabaseClient supBase;
  const LocalizationApiLoader({required this.supBase});

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {

    log('easy localization loader: load http $path');
    try {
      final data = await supBase.from('localization').select('key, ar, en');
      print(data);
      return { for (var item in data) item['key']: item[locale.languageCode]};


      /*  var url = Uri.parse('$path/${locale.toLanguageTag()}.json');
      return http
          .get(url)
          .then((response) => json.decode(utf8.decode(response.bodyBytes)));*/
    }on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: error.message);

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException(message: e.toString());
    }
  }
}