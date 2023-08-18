// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_watchlist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWatchListDTO _$GetWatchListDTOFromJson(Map<String, dynamic> json) =>
    GetWatchListDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => WatchListApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetWatchListDTOToJson(GetWatchListDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
