class CardSet {
  final String setName;
  final String setCode;
  final String setRarity;
  final String? setEdition;
  final String? setPrice;
  final String? setPriceLow;
  final String? setUrl;

  const CardSet({
    required this.setName,
    required this.setCode,
    required this.setRarity,
    this.setEdition,
    this.setPrice,
    this.setPriceLow,
    this.setUrl,
  });
}
