/// Enum representing card rarities with their full names and short abbreviations
enum Rarity {
  common('Common', 'C'),
  rare('Rare', 'R'),
  superRare('Super Rare', 'SR'),
  ultraRare('Ultra Rare', 'UR'),
  secretRare('Secret Rare', 'ScR'),
  ultimateRare('Ultimate Rare', 'UtR'),
  ghostRare('Ghost Rare', 'GHR'),
  platinumRare('Platinum Rare', 'PlR'),
  goldRare('Gold Rare', 'GR'),
  starlightRare('Starlight Rare', 'StR'),
  ;

  const Rarity(this.fullName, this.shortName);

  final String fullName;
  final String shortName;

  /// Gets the short abbreviation for a rarity string
  /// 
  /// Returns the short name if the rarity is known, otherwise
  /// returns the first 3 characters uppercase as a fallback.
  static String getShortRarity(String rarity) {
    final rarityEnum = fromString(rarity);
    if (rarityEnum != null) {
      return rarityEnum.shortName;
    }
    
    // Fallback for unknown rarities
    if (rarity.length >= 3) {
      return rarity.substring(0, 3).toUpperCase();
    }
    return rarity.toUpperCase();
  }

  /// Parses a rarity string into a Rarity enum value
  /// 
  /// Returns null if no matching rarity is found.
  static Rarity? fromString(String rarity) {
    final lowerRarity = rarity.toLowerCase().trim();
    
    // First, try exact matches
    for (final rarityEnum in Rarity.values) {
      if (lowerRarity == rarityEnum.fullName.toLowerCase()) {
        return rarityEnum;
      }
    }
    
    // Then, check more specific rarities first (longer names first to avoid matching "rare" too early)
    if (lowerRarity.contains('starlight') && lowerRarity.contains('rare')) {
      return Rarity.starlightRare;
    }
    if (lowerRarity.contains('platinum') && lowerRarity.contains('rare')) {
      return Rarity.platinumRare;
    }
    if (lowerRarity.contains('ultimate') && lowerRarity.contains('rare')) {
      return Rarity.ultimateRare;
    }
    if (lowerRarity.contains('secret') && lowerRarity.contains('rare')) {
      return Rarity.secretRare;
    }
    if (lowerRarity.contains('ghost') && lowerRarity.contains('rare')) {
      return Rarity.ghostRare;
    }
    if (lowerRarity.contains('gold') && lowerRarity.contains('rare')) {
      return Rarity.goldRare;
    }
    if (lowerRarity.contains('super') && lowerRarity.contains('rare') && 
        !lowerRarity.contains('ultra') && !lowerRarity.contains('secret')) {
      return Rarity.superRare;
    }
    if (lowerRarity.contains('ultra') && lowerRarity.contains('rare') && 
        !lowerRarity.contains('secret')) {
      return Rarity.ultraRare;
    }
    if (lowerRarity.contains('common') && !lowerRarity.contains('uncommon')) {
      return Rarity.common;
    }
    if (lowerRarity.contains('rare') && 
        !lowerRarity.contains('super') && 
        !lowerRarity.contains('ultra') && 
        !lowerRarity.contains('secret') &&
        !lowerRarity.contains('ultimate') &&
        !lowerRarity.contains('ghost') &&
        !lowerRarity.contains('platinum') &&
        !lowerRarity.contains('gold') &&
        !lowerRarity.contains('starlight')) {
      return Rarity.rare;
    }
    
    return null;
  }
}
