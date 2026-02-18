// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    _SettingsState(
      sortOption:
          $enumDecodeNullable(_$SortOptionEnumMap, json['sortOption']) ??
              SortOption.nameAZ,
      showDividers: json['showDividers'] as bool? ?? false,
      boxExclusiveSorting: json['boxExclusiveSorting'] as bool? ?? false,
      boxSortOptions: (json['boxSortOptions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, $enumDecode(_$SortOptionEnumMap, e)),
          ) ??
          const <String, SortOption>{},
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'sortOption': _$SortOptionEnumMap[instance.sortOption]!,
      'showDividers': instance.showDividers,
      'boxExclusiveSorting': instance.boxExclusiveSorting,
      'boxSortOptions': instance.boxSortOptions
          .map((k, e) => MapEntry(k, _$SortOptionEnumMap[e]!)),
    };

const _$SortOptionEnumMap = {
  SortOption.nameAZ: 'nameAZ',
  SortOption.cardType: 'cardType',
  SortOption.frameType: 'frameType',
  SortOption.archetype: 'archetype',
};
