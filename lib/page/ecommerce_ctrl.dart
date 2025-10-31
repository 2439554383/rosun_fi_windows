import 'package:get/get.dart';

class EcommerceCtrl extends GetxController {
  // 当前选中的标签页
  final RxInt selectedTabIndex = 0.obs;

  // 商品数据
  final RxList<Map<String, dynamic>> recommendedProducts =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> popularProducts =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  // 搜索相关
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 切换标签页
  void switchTab(int index) {
    selectedTabIndex.value = index;
  }

  // 搜索商品
  void searchProducts(String query) {
    searchQuery.value = query;
    isSearching.value = query.isNotEmpty;
    // 这里可以添加实际的搜索逻辑
  }

  // 加载模拟数据
  void _loadMockData() {
    // 推荐商品数据
    recommendedProducts.value = [
      {
        'id': 1,
        'title': '商品1',
        'image': 'https://via.placeholder.com/76x76',
        'price': 10.99,
        'brand': '品牌A',
      },
      {
        'id': 2,
        'title': '商品2',
        'image': 'https://via.placeholder.com/76x76',
        'price': 15.99,
        'brand': '品牌B',
      },
      {
        'id': 3,
        'title': '商品3',
        'image': 'https://via.placeholder.com/76x76',
        'price': 8.99,
        'brand': '品牌C',
      },
      {
        'id': 4,
        'title': '商品4',
        'image': 'https://via.placeholder.com/76x76',
        'price': 12.99,
        'brand': '品牌D',
      },
    ];

    // 热门商品数据
    popularProducts.value = [
      {
        'id': 5,
        'title': '热门商品1',
        'image': 'https://via.placeholder.com/148x148',
        'price': 25.99,
        'brand': '热门品牌A',
      },
      {
        'id': 6,
        'title': '热门商品2',
        'image': 'https://via.placeholder.com/148x148',
        'price': 35.99,
        'brand': '热门品牌B',
      },
      {
        'id': 7,
        'title': '热门商品3',
        'image': 'https://via.placeholder.com/148x148',
        'price': 29.99,
        'brand': '热门品牌C',
      },
    ];

    // 分类数据
    categories.value = [
      {'id': 1, 'title': '分类1', 'image': 'https://via.placeholder.com/96x96'},
      {'id': 2, 'title': '分类2', 'image': 'https://via.placeholder.com/96x96'},
      {'id': 3, 'title': '分类3', 'image': 'https://via.placeholder.com/96x96'},
      {'id': 4, 'title': '分类4', 'image': 'https://via.placeholder.com/96x96'},
    ];
  }

  // 刷新数据
  void refreshData() {
    _loadMockData();
  }

  // 获取商品详情
  void getProductDetail(int productId) {
    // 这里可以添加获取商品详情的逻辑
    print('获取商品详情: $productId');
  }

  // 添加到购物车
  void addToCart(int productId) {
    // 这里可以添加添加到购物车的逻辑
    print('添加到购物车: $productId');
  }

  // 收藏商品
  void toggleFavorite(int productId) {
    // 这里可以添加收藏商品的逻辑
    print('切换收藏状态: $productId');
  }
}
