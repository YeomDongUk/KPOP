import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MusicVideo extends Equatable {
  final String id;
  final String title;
  final String description;
  final String thumbnail;

  MusicVideo(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.thumbnail});

  @override
  List<Object> get props => [id, title, description, thumbnail];
}
