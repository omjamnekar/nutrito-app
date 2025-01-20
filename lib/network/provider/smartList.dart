import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/data/model/gen/smart/shopping.dart';

class SmartlistProvider extends StateNotifier<List<ShoppingItemManager>> {
  SmartlistProvider() : super([]);

  void setState(ShoppingItemManager shoppingItem) {
    state = [...state, shoppingItem];
  }

  void popItemState(String name) {
    state = state.where((item) => item.name != name).toList();
  }
}

class CartlistProvider extends StateNotifier<List<ShoppingItemManager>> {
  CartlistProvider() : super([]);

  void setState(ShoppingItemManager shoppingItem) {
    state = [...state, shoppingItem];
    print(state);
  }

  void popItemState(String name) {
    state = state.where((item) => item.name != name).toList();
  }
}

// Riverpod Providers
final cartlistPovider =
    StateNotifierProvider<CartlistProvider, List<ShoppingItemManager>>(
  (ref) => CartlistProvider(),
);

final smartlistProvider =
    StateNotifierProvider<SmartlistProvider, List<ShoppingItemManager>>(
  (ref) => SmartlistProvider(),
);
