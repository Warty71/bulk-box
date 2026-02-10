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
}
