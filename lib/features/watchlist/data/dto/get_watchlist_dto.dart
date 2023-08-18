import 'package:filmcrate/features/watchlist/data/model/watchlist_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_watchlist_dto.g.dart';

@JsonSerializable()
class GetWatchListDTO {
  final List<WatchListApiModel> data;

  const GetWatchListDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetWatchListDTOToJson(this);

  factory GetWatchListDTO.fromJson(Map<String, dynamic> json) =>
      _$GetWatchListDTOFromJson(json);
}
