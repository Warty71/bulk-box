enum SortOption {
  nameAZ,
  cardType,
}

extension SortOptionExtension on SortOption {
  String get label {
    return switch (this) {
      SortOption.nameAZ => 'Name (A-Z)',
      SortOption.cardType => 'Card Type',
    };
  }
}
