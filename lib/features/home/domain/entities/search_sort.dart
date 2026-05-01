enum SearchSortField { rate, date }

class SearchSort {
  final SearchSortField field;
  final bool ascending;

  const SearchSort({required this.field, required this.ascending});

  SearchSort toggleDirection() => SearchSort(field: field, ascending: !ascending);
}
