/// Searches the first dimension of a 2D array.
///
/// Returns the index of the first element where `a[i][0] == k`, or -1 if not found.
///
/// Example:
/// ```dart
/// final arr = [[1, 100], [3, 200], [5, 300]];
/// int index = search2DArray(3, arr); // returns 1
/// ```
int search2DArray(int key, List<List<int>> array) {
  int low = 0;
  int high = array.length - 1;

  while (low <= high) {
    int mid = ((low + high) / 2).floor();

    if (array[mid][0] > key) {
      high = mid - 1;
    } else if (array[mid][0] < key) {
      low = mid + 1;
    } else {
      return mid;
    }
  }

  return -1;
}

/// Searches a 1D array.
///
/// Returns the index of the element where `a[i] == key`, or -1 if not found.
///
/// Example:
/// ```dart
/// final arr = [2, 4, 6, 8];
/// int index = search1DArray(6, arr); // returns 2
/// ```
int search1DArray(double key, List<int> array) {
  int low = 0;
  int high = array.length - 1;

  while (low <= high) {
    int mid = ((low + high) / 2).floor();

    if (array[mid] > key) {
      high = mid - 1;
    } else if (array[mid] < key) {
      low = mid + 1;
    } else {
      return mid;
    }
  }

  return -1;
}
