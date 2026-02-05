/// A physical box the user uses to organise their collection.
class Box {
  final int id;
  final String name;
  final String? color;
  final int sortOrder;
  final DateTime createdAt;

  const Box({
    required this.id,
    required this.name,
    this.color,
    this.sortOrder = 0,
    required this.createdAt,
  });
}
