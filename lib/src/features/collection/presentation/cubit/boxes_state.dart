import 'package:bulk_box/src/features/collection/domain/entities/box.dart';

abstract class BoxesState {
  const BoxesState();
}

class BoxesInitial extends BoxesState {
  const BoxesInitial();
}

class BoxesLoading extends BoxesState {
  const BoxesLoading();
}

class BoxesLoaded extends BoxesState {
  final List<Box> boxes;

  const BoxesLoaded(this.boxes);
}

class BoxesError extends BoxesState {
  final String message;

  const BoxesError(this.message);
}
