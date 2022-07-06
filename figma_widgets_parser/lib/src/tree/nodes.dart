import 'package:equatable/equatable.dart';

import 'values.dart';

abstract class Node extends Equatable {
  const Node();
  const factory Node.tag(
    String identifier, {
    List<TagNodeProperty> properties,
    List<Node> children,
  }) = TagNode;
  const factory Node.text(String text) = TextNode;
}

class TextNode extends Node {
  const TextNode(this.text);
  final String text;

  @override
  List<Object?> get props => [text];
}

class TagNode extends Node {
  const TagNode(
    this.identifier, {
    this.properties = const <TagNodeProperty>[],
    this.children = const <Node>[],
  });
  final String identifier;
  final List<TagNodeProperty> properties;
  final List<Node> children;

  @override
  List<Object?> get props => [
        identifier,
        properties,
        children,
      ];
}

abstract class TagNodeProperty extends Equatable {
  const TagNodeProperty();
  const factory TagNodeProperty.member(String name, Value value) =
      TagNodeMemberProperty;
  const factory TagNodeProperty.aggregate(String reference) =
      TagNodeAggregateProperty;
}

class TagNodeMemberProperty extends TagNodeProperty {
  const TagNodeMemberProperty(this.name, this.value);
  final String name;
  final Value value;

  @override
  List<Object?> get props => [
        name,
        value,
      ];
}

class TagNodeAggregateProperty extends TagNodeProperty {
  const TagNodeAggregateProperty(this.reference);
  final String reference;

  @override
  List<Object?> get props => [reference];
}
