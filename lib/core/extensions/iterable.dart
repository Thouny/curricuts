typedef GroupByKey<K, E> = K Function(E item);

extension Iterables<E> on Iterable<E> {
  /// Returns a [Map<K, List<E>>] of the given `List<E>`.
  ///
  /// Allows easy grouping of a list of items, based on a related
  /// property (eg. a many-to-one relationship of options to a question ID).
  ///
  /// ```dart
  /// final list = [
  ///   SomeModel(parentId: 1, text: "Option 1 text"),
  ///   SomeModel(parentId: 1, text: "Option 2 text"),
  ///   SomeModel(parentId: 1, text: "Option 3 text"),
  ///   SomeModel(parentId: 2, text: "Option 1 text"),
  ///   SomeModel(parentId: 2, text: "Option 2 text"),
  ///   SomeModel(parentId: 2, text: "Option 3 text"),
  /// ]
  ///
  /// final grouped = list.groupBy((item) => item.parentId).entries.toList();
  /// ```
  ///
  /// Result:
  ///```json
  ///  {
  ///     1: [
  ///       SomeModel(parentId: 1, text: "Option 1 text"),
  ///       SomeModel(parentId: 1, text: "Option 2 text"),
  ///       SomeModel(parentId: 1, text: "Option 3 text"),
  ///     ],
  ///     2: [
  ///       SomeModel(parentId: 2, text: "Option 1 text"),
  ///       SomeModel(parentId: 2, text: "Option 2 text"),
  ///       SomeModel(parentId: 2, text: "Option 3 text"),
  ///     ]
  ///  }
  ///```
  ///
  Map<K, List<E>> groupBy<K>(GroupByKey<K, E> keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
