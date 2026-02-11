enum SortOption {
  nameAZ,
  cardType,
  frameType,
  archetype,
}

extension SortOptionExtension on SortOption {
  String get label {
    return switch (this) {
      SortOption.nameAZ => 'Name (A-Z)',
      SortOption.cardType => 'Card Type',
      SortOption.frameType => 'Frame Type',
      SortOption.archetype => 'Archetype',
    };
  }

  String get description {
    return switch (this) {
      SortOption.nameAZ => 'e.g. Ash Blossom, Blue-Eyes, Dark Magician',
      SortOption.cardType => 'e.g. Effect Monster, Spell Card, Trap Card',
      SortOption.frameType => 'e.g. Fusion, Synchro, XYZ, Link',
      SortOption.archetype => 'e.g. Blue-Eyes, Dark Magician, Branded',
    };
  }
}
