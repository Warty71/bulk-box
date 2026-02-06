import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';

const collectionGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3,
  childAspectRatio: 0.686,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
);

const collectionGridPadding = EdgeInsets.all(Dimensions.md);
