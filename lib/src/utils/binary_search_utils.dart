/// Search first dimension in a 2D array.
///
/// `k` - Key,
/// `a` - Array
///
/// Return `index`
int searchOf2DArray(double k, List<List<int>> a) {
  int i = 0;
  int l = 0;
  int u = a.length - 1;
  while (u >= l) {
    i = ((l + u) / 2.0).floor();
    if (a[i][0] > k) {
      u = i - 1;
    } else if (a[i][0] < k) {
      l = i + 1;
    } else {
      return i;
    }
  }
  return -1;
}

/// Search first dimension in a 1D array.
///
/// `k` - Key,
/// `a` - Array
///
/// Return `index`
int searchOf1DArray(double k, List<int> a) {
  int i = 0;
  int l = 0;
  int u = a.length - 1;

  while (u >= l) {
    i = ((l + u) / 2.0).floor();
    if (a[i] > k) {
      u = i - 1;
    } else if (a[i] < k) {
      l = i + 1;
    } else {
      return i;
    }
  }
  return -1;
}
