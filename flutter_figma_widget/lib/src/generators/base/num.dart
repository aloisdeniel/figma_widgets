extension DoubleGenerator on double {
  String toDart() {
    if (isFinite) return toString();
    if (this == double.infinity) return 'double.infinity';
    if (this == double.negativeInfinity) return 'double.negativeInfinity';
    return '0.0';
  }
}
