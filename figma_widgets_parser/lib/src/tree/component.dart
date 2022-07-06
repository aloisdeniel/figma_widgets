import 'package:equatable/equatable.dart';

import 'nodes.dart';

class Component extends Equatable {
  const Component({
    required this.name,
    required this.tree,
  });
  final String name;
  final TagNode tree;

  @override
  List<Object?> get props => [name];
}
