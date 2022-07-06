import 'package:equatable/equatable.dart';

abstract class Value extends Equatable {
  const Value();
  const factory Value.primitive(Object? value) = PrimitiveValue;
  const factory Value.reference(String name) = ReferenceValue;
  const factory Value.array(List<Value> items) = ArrayValue;
  const factory Value.object(Map<String, Value> items) = ObjectValue;
}

class PrimitiveValue extends Value {
  const PrimitiveValue(this.value);
  final Object? value;

  @override
  List<Object?> get props => [value];
}

class ReferenceValue extends Value {
  const ReferenceValue(this.name);
  final String name;
  @override
  List<Object?> get props => [name];
}

class ArrayValue extends Value {
  const ArrayValue(this.items);
  final List<Value> items;
  @override
  List<Object?> get props => [items];
}

class ObjectValue extends Value {
  const ObjectValue(this.items);
  final Map<String, Value> items;

  Value? operator [](String key) => items[key];

  Iterable<String> get keys => items.keys;

  int get length => items.length;
  @override
  List<Object?> get props => [items];
}
