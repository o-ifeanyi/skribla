// typedef LocatorFactory = T Function<T>();

// final class Locator {
//   Locator._private();
//   static final _instance = Locator._private();
//   static Locator get instance => _instance;

//   final _singletons = <Type, Object>{};

//   void set<T>(T instance) {
//     switch (_singletons[T]) {
//       case final Object _:
//         throw AssertionError('Already set: $T');
//       case _:
//         _singletons[T] = instance as Object;
//     }
//   }

//   T get<T>() {
//     switch (_singletons[T]) {
//       case final T Function() factory:
//         return factory();
//       case final T instance:
//         return instance;
//       case _:
//         throw ArgumentError('Not set: $T');
//     }
//   }

//   void factory<T>(T Function(LocatorFactory) fn) {
//     switch (_singletons[T]) {
//       case final Object _:
//         throw AssertionError('Already set: $T');
//       case _:
//         _singletons[T] = () => fn(get);
//     }
//   }
// }
