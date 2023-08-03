import 'dart:math';

class WeightedItem<T> {
  final T item;
  final double weight;

  WeightedItem(this.item, this.weight);
}

class WeightedRandom {
  static int generate<T>(List<WeightedItem<T>> weightedItems) {
    final totalWeight = weightedItems.map((item) => item.weight).reduce((a, b) => a + b);
    final random = Random().nextDouble() * totalWeight;

    print('RANDOM is $random');
    double cumulativeWeight = 0;
    for( var i = 0; i < weightedItems.length; i++){
      cumulativeWeight += weightedItems[i].weight;
      if (random < cumulativeWeight) {
        return i;
      }
    }

    // Fallback return, should never reach this point unless the list is empty.
    return 0;
  }
}