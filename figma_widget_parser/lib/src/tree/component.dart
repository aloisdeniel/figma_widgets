import 'package:equatable/equatable.dart';
import 'package:figma_widget_parser/figma_widget_parser.dart';

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
