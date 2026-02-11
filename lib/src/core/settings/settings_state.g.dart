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
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'sortOption': _$SortOptionEnumMap[instance.sortOption]!,
      'showDividers': instance.showDividers,
    };

const _$SortOptionEnumMap = {
  SortOption.nameAZ: 'nameAZ',
  SortOption.cardType: 'cardType',
  SortOption.frameType: 'frameType',
  SortOption.archetype: 'archetype',
};
