import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_search_filters.freezed.dart';

/// Broad card frame category, used for multi-select OR filtering.
///
/// All values are applied **client-side** by matching [YgoCard.frameType]
/// because the API `type` param requires exact compound strings and silently
/// misses sub-variants (e.g. `type=Synchro Monster` excludes
/// `Synchro Tuner Monster`; `type=Effect Monster` excludes Tuner monsters).
/// Using frameType is broader and matches user intent.
///
/// Multiple selections are combined with OR: a card matches if its frameType
/// matches *any* of the selected types.
enum CardType {
  effectMonster,
  normalMonster,
  fusionMonster,
  ritualMonster,
  synchroMonster,
  xyzMonster,
  linkMonster,
  pendulumMonster,
  spellCard,
  trapCard;

  /// The `frameType` value to match against [YgoCard.frameType].
  /// For [pendulumMonster] this is used as a `contains` check because pendulum
  /// frameTypes are compound strings like `'effect_pendulum'`.
  String get frameTypeValue => switch (this) {
        CardType.effectMonster => 'effect',
        CardType.normalMonster => 'normal',
        CardType.fusionMonster => 'fusion',
        CardType.ritualMonster => 'ritual',
        CardType.synchroMonster => 'synchro',
        CardType.xyzMonster => 'xyz',
        CardType.linkMonster => 'link',
        CardType.pendulumMonster => 'pendulum',
        CardType.spellCard => 'spell',
        CardType.trapCard => 'trap',
      };

  String get displayName => switch (this) {
        CardType.effectMonster => 'Effect',
        CardType.normalMonster => 'Normal',
        CardType.fusionMonster => 'Fusion',
        CardType.ritualMonster => 'Ritual',
        CardType.synchroMonster => 'Synchro',
        CardType.xyzMonster => 'XYZ',
        CardType.linkMonster => 'Link',
        CardType.pendulumMonster => 'Pendulum',
        CardType.spellCard => 'Spell',
        CardType.trapCard => 'Trap',
      };
}

/// Monster sub-classification, independent of the frame/extra-deck category.
///
/// Applied **client-side** by checking whether [YgoCard.type] contains the
/// [typeKeyword]. This works because the API always encodes subtypes as part
/// of the compound `type` string:
///   - "Synchro **Tuner** Monster"
///   - "**Flip** **Tuner** Effect Monster"
///   - "**Gemini** Monster"
///
/// Multiple selections are combined with OR: a card matches if its type string
/// contains *any* of the selected subtype keywords.
enum MonsterSubtype {
  tuner,
  flip,
  gemini,
  spirit,
  union,
  toon;

  /// The substring always present in the compound `type` string for this
  /// subtype, e.g. `'Tuner'` matches "Tuner Monster", "Synchro Tuner Monster",
  /// "Flip Tuner Effect Monster", etc.
  String get typeKeyword => switch (this) {
        MonsterSubtype.tuner => 'Tuner',
        MonsterSubtype.flip => 'Flip',
        MonsterSubtype.gemini => 'Gemini',
        MonsterSubtype.spirit => 'Spirit',
        MonsterSubtype.union => 'Union',
        MonsterSubtype.toon => 'Toon',
      };

  String get displayName => switch (this) {
        MonsterSubtype.tuner => 'Tuner',
        MonsterSubtype.flip => 'Flip',
        MonsterSubtype.gemini => 'Gemini',
        MonsterSubtype.spirit => 'Spirit',
        MonsterSubtype.union => 'Union',
        MonsterSubtype.toon => 'Toon',
      };
}

enum CardAttribute {
  dark,
  light,
  fire,
  earth,
  water,
  wind,
  divine;

  String get apiValue => name.toUpperCase();

  String get displayName => name.toUpperCase();
}

enum CardRace {
  dragon,
  warrior,
  spellcaster,
  beast,
  beastWarrior,
  wingedBeast,
  fiend,
  fairy,
  insect,
  dinosaur,
  machine,
  aqua,
  pyro,
  thunder,
  rock,
  plant,
  psychic,
  cyberse,
  zombie,
  wyrm,
  continuous,
  counter,
  equip,
  field,
  normalSub,
  quickPlay,
  ritual;

  String get apiValue => switch (this) {
        CardRace.dragon => 'Dragon',
        CardRace.warrior => 'Warrior',
        CardRace.spellcaster => 'Spellcaster',
        CardRace.beast => 'Beast',
        CardRace.beastWarrior => 'Beast-Warrior',
        CardRace.wingedBeast => 'Winged Beast',
        CardRace.fiend => 'Fiend',
        CardRace.fairy => 'Fairy',
        CardRace.insect => 'Insect',
        CardRace.dinosaur => 'Dinosaur',
        CardRace.machine => 'Machine',
        CardRace.aqua => 'Aqua',
        CardRace.pyro => 'Pyro',
        CardRace.thunder => 'Thunder',
        CardRace.rock => 'Rock',
        CardRace.plant => 'Plant',
        CardRace.psychic => 'Psychic',
        CardRace.cyberse => 'Cyberse',
        CardRace.zombie => 'Zombie',
        CardRace.wyrm => 'Wyrm',
        CardRace.continuous => 'Continuous',
        CardRace.counter => 'Counter',
        CardRace.equip => 'Equip',
        CardRace.field => 'Field',
        CardRace.normalSub => 'Normal',
        CardRace.quickPlay => 'Quick-Play',
        CardRace.ritual => 'Ritual',
      };

  String get displayName => switch (this) {
        CardRace.dragon => 'Dragon',
        CardRace.warrior => 'Warrior',
        CardRace.spellcaster => 'Spellcaster',
        CardRace.beast => 'Beast',
        CardRace.beastWarrior => 'Beast-Warrior',
        CardRace.wingedBeast => 'Winged Beast',
        CardRace.fiend => 'Fiend',
        CardRace.fairy => 'Fairy',
        CardRace.insect => 'Insect',
        CardRace.dinosaur => 'Dinosaur',
        CardRace.machine => 'Machine',
        CardRace.aqua => 'Aqua',
        CardRace.pyro => 'Pyro',
        CardRace.thunder => 'Thunder',
        CardRace.rock => 'Rock',
        CardRace.plant => 'Plant',
        CardRace.psychic => 'Psychic',
        CardRace.cyberse => 'Cyberse',
        CardRace.zombie => 'Zombie',
        CardRace.wyrm => 'Wyrm',
        CardRace.continuous => 'Continuous',
        CardRace.counter => 'Counter',
        CardRace.equip => 'Equip',
        CardRace.field => 'Field',
        CardRace.normalSub => 'Normal',
        CardRace.quickPlay => 'Quick-Play',
        CardRace.ritual => 'Ritual',
      };
}

enum BanlistFilter {
  tcg,
  ocg,
  goat;

  String get apiValue => switch (this) {
        BanlistFilter.tcg => 'TCG',
        BanlistFilter.ocg => 'OCG',
        BanlistFilter.goat => 'Goat',
      };

  String get displayName => switch (this) {
        BanlistFilter.tcg => 'TCG',
        BanlistFilter.ocg => 'OCG',
        BanlistFilter.goat => 'Goat',
      };
}

enum CardSortBy {
  atk,
  def,
  name,
  type,
  level,
  id,
  newest;

  String get apiValue => switch (this) {
        CardSortBy.newest => 'new',
        CardSortBy.atk => 'atk',
        CardSortBy.def => 'def',
        CardSortBy.name => 'name',
        CardSortBy.type => 'type',
        CardSortBy.level => 'level',
        CardSortBy.id => 'id',
      };

  String get displayName => switch (this) {
        CardSortBy.atk => 'ATK',
        CardSortBy.def => 'DEF',
        CardSortBy.name => 'Name',
        CardSortBy.type => 'Type',
        CardSortBy.level => 'Level',
        CardSortBy.id => 'ID',
        CardSortBy.newest => 'Newest',
      };
}

@freezed
abstract class CardSearchFilters with _$CardSearchFilters {
  const CardSearchFilters._();

  const factory CardSearchFilters({
    /// Multi-select: OR within the group (card matches if frameType == any).
    @Default(<CardType>[]) List<CardType> types,

    /// Multi-select: OR within the group (card matches if type contains any keyword).
    @Default(<MonsterSubtype>[]) List<MonsterSubtype> subtypes,

    CardAttribute? attribute,
    CardRace? race,
    int? level,
    String? archetype,
    BanlistFilter? banlist,
    @Default(false) bool staplesOnly,
    CardSortBy? sortBy,
  }) = _CardSearchFilters;

  bool get isEmpty =>
      types.isEmpty &&
      subtypes.isEmpty &&
      attribute == null &&
      race == null &&
      level == null &&
      (archetype == null || archetype!.isEmpty) &&
      banlist == null &&
      !staplesOnly &&
      sortBy == null;

  int get activeCount => [
        types.isNotEmpty,
        subtypes.isNotEmpty,
        attribute != null,
        race != null,
        level != null,
        archetype != null && archetype!.isNotEmpty,
        banlist != null,
        staplesOnly,
        sortBy != null,
      ].where((v) => v).length;
}
