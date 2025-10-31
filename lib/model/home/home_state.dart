import 'stock_model.dart';

class HomeState {
  final List<Stock> stockList;
  final List<Transaction> transactionList;
  final List<PerformanceData> performanceData;
  final int currentPage;
  final int totalPages;
  final bool isLoading;
  final String? errorMessage;
  final String? searchKeyword;

  const HomeState({
    this.stockList = const [],
    this.transactionList = const [],
    this.performanceData = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.isLoading = false,
    this.errorMessage,
    this.searchKeyword,
  });

  HomeState copyWith({
    List<Stock>? stockList,
    List<Transaction>? transactionList,
    List<PerformanceData>? performanceData,
    int? currentPage,
    int? totalPages,
    bool? isLoading,
    String? errorMessage,
    String? searchKeyword,
  }) {
    return HomeState(
      stockList: stockList ?? this.stockList,
      transactionList: transactionList ?? this.transactionList,
      performanceData: performanceData ?? this.performanceData,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }
}
