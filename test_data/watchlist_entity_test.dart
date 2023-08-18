import 'dart:convert';

import 'package:filmcrate/features/watchlist/domain/entity/watchlist_entity.dart';
import 'package:flutter/services.dart';

Future<List<WatchListEntity>> getWatchListTest() async {
  final response =
      await rootBundle.loadString('test_data/watchlist_entity_test.json');
  final jsonList = await json.decode(response);

  final List<WatchListEntity> watchlist = jsonList
      .map<WatchListEntity>(
        (json) => WatchListEntity.fromJson(json),
      )
      .toList();

  return Future.value(watchlist);
}
