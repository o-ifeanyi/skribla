// import 'package:flutter/material.dart';

// class Provider<T extends Listenable> extends InheritedNotifier<T> {
//   const Provider({
//     required super.child,
//     required super.notifier,
//     super.key,
//   });

//   static T of<T extends Listenable>(
//     BuildContext context, {
//     bool listen = true,
//   }) {
//     final provider = switch (listen) {
//       true => context.dependOnInheritedWidgetOfExactType<Provider<T>>(),
//       _ => context.getInheritedWidgetOfExactType<Provider<T>>(),
//     };

//     if (provider == null) {
//       throw Exception('No Provider found in context');
//     }

//     final notifier = provider.notifier;

//     if (notifier == null) {
//       throw Exception('No notifier found in Provider');
//     }

//     return notifier;
//   }
// }

// extension ProviderExt on BuildContext {
//   T read<T extends Listenable>() => Provider.of<T>(this, listen: false);
//   T watch<T extends Listenable>() => Provider.of<T>(this);
//   R select<T extends Listenable, R>(R Function(T provider) selector) {
//     final provider = Provider.of<T>(this, listen: false);
//     return selector.call(provider);
//   }
// }

// class Consumer<T extends Listenable> extends StatelessWidget {
//   const Consumer({
//     required this.builder,
//     this.child,
//     super.key,
//   });

//   final Widget Function(
//     BuildContext context,
//     T value,
//     Widget? child,
//   ) builder;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return builder(
//       context,
//       context.watch<T>(),
//       child,
//     );
//   }
// }

// class Consumer2<A extends Listenable, B extends Listenable>
//     extends StatelessWidget {
//   const Consumer2({
//     required this.builder,
//     this.child,
//     super.key,
//   });

//   final Widget Function(
//     BuildContext context,
//     A valueA,
//     B valueB,
//     Widget? child,
//   ) builder;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return builder(
//       context,
//       context.watch<A>(),
//       context.watch<B>(),
//       child,
//     );
//   }
// }

// class Selector<T extends Listenable, R> extends StatelessWidget {
//   const Selector({
//     required this.selector,
//     required this.builder,
//     super.key,
//   });
//   final R Function(T provider) selector;
//   final Widget Function(
//     BuildContext context,
//     R value,
//     Widget? child,
//   ) builder;

//   @override
//   Widget build(BuildContext context) {
//     final selectedValue = selector(context.read<T>());

//     return Consumer<T>(
//       builder: (context, value, child) {
//         final newSelectedValue = selector(value);

//         if (selectedValue == newSelectedValue) {
//           return child!;
//         }

//         return builder(context, newSelectedValue, child);
//       },
//     );
//   }
// }
