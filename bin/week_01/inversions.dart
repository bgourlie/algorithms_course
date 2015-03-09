void main() {
  final a = [1,2,5,6,4,9,8,3,7,0]; // correct answer is 19 inversions
  final inversions = countInversions(a);
  print('Number of inversions: $inversions');
}


int _mergeAndCountSplits(List<int> left, List<int> right, List<int> a){
  assert(a.length == left.length + right.length);
  final leftBound = left.length;
  final rightBound = right.length;
  final total = leftBound + rightBound;

  int i = 0;
  int curL = 0;
  int curR = 0;
  int inversions = 0;

  while(curL + curR < total){
    if(curL >= leftBound){
      for(int j = curR; j < rightBound; j++){
        a[i++] = right[curR++];
      }
    } else if (curR >= rightBound){
      for(int j = curL; j < leftBound; j++){
        a[i++] = left[curL++];
      }
    }else{
      if(left[curL] < right[curR]){
        a[i++] = left[curL++];
      } else {
        a[i++] = right[curR++];
        inversions += leftBound - curL;
      }
    }
  }

  return inversions;
}

int countInversions(List<int> a){
  final n = a.length;

  if(n < 2) {
    return 0;
  }

  if(n == 2){
    if(a[0] > a[1]){
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
  for(int i = 0; i < half; i++){
    left[i] = a[i];
    right[i] = a[i + half];
  }

  if(isOdd){
    right[rBound - 1] = a[n - 1];
  }

  final leftInversions = countInversions(left);
  final rightInversions = countInversions(right);
  final splitInversions = _mergeAndCountSplits(left, right, a);
  return leftInversions + rightInversions + splitInversions;
}
