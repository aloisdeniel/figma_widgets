import 'package:equatable/equatable.dart';

abstract class Value extends Equatable {
  const Value();
  const factory Value.primitive(Object? value) = PrimitiveValue;
  const factory Value.reference(String name) = ReferenceValue;
  const factory Value.array(List<Value> items) = ArrayValue;
  const factory Value.object(Map<String, Value> items) = ObjectValue;
}

extension ValueExtensions on Value? {
  T map<T>({
    required T Function() orElse,
    T Function(String name, T Function() orElse)? reference,
    T Function(Object? value, T Function() orElse)? primitive,
    T Function(List<Value> items, T Function() orElse)? array,
    T Function(Map<String, Value> items, T Function() orElse)? object,
  }) {
    final value = this;
    if (primitive != null && value is PrimitiveValue) {
      return primitive(value.value, orElse);
    }
    if (reference != null && value is ReferenceValue) {
      return reference(value.name, orElse);
    }
    if (array != null && value is ArrayValue) {
      return array(value.items, orElse);
    }
    if (object != null && value is ObjectValue) {
      return object(value.items, orElse);
    }
    return orElse();
  }
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
