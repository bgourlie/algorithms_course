void main() {
  final l1 = [1, 3, 5, 9, 11, 23, 201, 202];
  final l2 = [2, 2, 3, 9, 10, 300, 301, 415, 500];
  final a = new List<int>(l1.length + l2.length);
  _merge(l1, l2, a);
  print(a);

  final sorted = [
    99,
    54,
    10534,
    42,
    9,
    2,
    4,
    4,
    23,
    54,
    62,
    88,
    33,
    101,
    1,
    2,
    2,
    1,
    7,
    4,
    77,
    6,
    143
  ];
  mergeSort(sorted);
  print(sorted);
}

void _merge(List<int> left, List<int> right, List<int> a) {
  assert(a.length == left.length + right.length);
  final leftBound = left.length;
  final rightBound = right.length;
  final total = leftBound + rightBound;
  int i = 0;
  int curL = 0;
  int curR = 0;

  while (curL + curR < total) {
    if (curL >= leftBound) {
      for (int j = curR; j < rightBound; j++) {
        a[i++] = right[curR++];
      }
    } else if (curR >= rightBound) {
      for (int j = curL; j < leftBound; j++) {
        a[i++] = left[curL++];
      }
    } else {
      if (left[curL] < right[curR]) {
        a[i++] = left[curL++];
      } else {
        a[i++] = right[curR++];
      }
    }
  }
}

void mergeSort(List<int> a) {
  final n = a.length;

  if (n < 2) {
    return;
  }

  if (n == 2) {
    if (a[0] > a[1]) {
      final tmp = a[0];
      a[0] = a[1];
      a[1] = tmp;
    }
    return;
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

  mergeSort(left);
  mergeSort(right);
  _merge(left, right, a);
}
