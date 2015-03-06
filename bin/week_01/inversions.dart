void main() {
  final a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
  final inversions = countInversions(a);
  print('Number of inversions: $inversions');
}

int _countSplitInversions(List<int> left, List<int> right) {
  print('count splits called.');
  final leftBound = left.length;
  final rightBound = right.length;
  final total = leftBound + rightBound;
  int inversions = 0;
  int i = 0;
  int curL = 0;
  int curR = 0;

  while (curL + curR < total) {
    if (curL >= leftBound || curR >= rightBound) {
      // there are no more inversions to check
      return inversions;
    }

    if (left[curL++] > right[curR++]) {
      inversions++;
    }
  }

  return inversions;
}

int countInversions(List<int> a) {
  final n = a.length;

  if (n < 2) {
    return 0;
  }

  if (n == 2) {
    if (a[0] > a[1]) {
      final tmp = a[0];
      a[0] = a[1];
      a[1] = tmp;
      return 1;
    }
    return 0;
  }

  final isOdd = n % 2 == 1;
  final half = (n / 2).floor();
  final left = new List(half);
  final rBound = half + (isOdd ? 1 : 0);
  final right = new List(rBound);
  for (int i = 0; i < half; i++) {
    left[i] = a[i];
    right[i] = a[i + half];
  }

  if (isOdd) {
    right[rBound - 1] = a[n - 1];
  }

  final leftInversions = countInversions(left);
  final rightInversions = countInversions(right);
  final splitInversions = _countSplitInversions(left, right);
  return leftInversions + rightInversions + splitInversions;
}
