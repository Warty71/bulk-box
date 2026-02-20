class SetInfo {
  final String setName;
  final String setCode;
  final int numOfCards;
  final String tcgDate;
  final String? setImage;

  const SetInfo({
    required this.setName,
    required this.setCode,
    required this.numOfCards,
    required this.tcgDate,
    this.setImage,
  });
}
