import 'package:flutter/material.dart';
import 'package:movie_tracker/features/detail/domain/entities/genre.dart';

class GenreChipWidget extends StatelessWidget {
  final Genre genre;

  const GenreChipWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(genre.name),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
