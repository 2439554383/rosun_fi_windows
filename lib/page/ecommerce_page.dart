import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosun_fi_windows/widget/public.dart';

class EcommercePage extends StatelessWidget {
  const EcommercePage({super.key});

  @override
  Widget build(BuildContext context) {
    PublicWidget pW = PublicWidget();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('电商'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF333333),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 状态栏区域
            _buildStatusBar(pW),

            // 搜索栏
            _buildSearchBar(pW),

            // 功能标签
            _buildPills(pW),

            // 横幅广告
            _buildBanner(pW),

            // 商品轮播区域
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProductCarousel(pW, '推荐商品'),
                    pW.Box(h: 20.h),
                    _buildProductGrid(pW, '热门商品'),
                    pW.Box(h: 20.h),
                    _buildCategoryGrid(pW, '分类'),
                    pW.Box(h: 100.h), // 底部导航栏空间
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomTabBar(pW),
    );
  }

  Widget _buildStatusBar(PublicWidget pW) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000000),
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, size: 16.w),
              SizedBox(width: 4.w),
              Icon(Icons.wifi, size: 16.w),
              SizedBox(width: 4.w),
              Icon(Icons.battery_full, size: 16.w),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(PublicWidget pW) {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Icon(Icons.search, size: 24.w, color: const Color(0xFF666666)),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              '搜索商品...',
              style: TextStyle(fontSize: 16.sp, color: const Color(0xFF999999)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPills(PublicWidget pW) {
    return Container(
      height: 32.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          _buildPill('收藏', Icons.favorite, pW),
          SizedBox(width: 8.w),
          _buildPill('历史', Icons.history, pW),
          SizedBox(width: 8.w),
          _buildPill('关注', Icons.person_add, pW),
          SizedBox(width: 8.w),
          _buildPill('订单', Icons.shopping_bag, pW),
        ],
      ),
    );
  }

  Widget _buildPill(String label, IconData icon, PublicWidget pW) {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.w, color: const Color(0xFF666666)),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF666666)),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(PublicWidget pW) {
    return Container(
      width: 343.w,
      height: 136.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(
          'assets/images/Banner.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE0E0E0),
              child: Center(
                child: Text(
                  '横幅广告',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCarousel(PublicWidget pW, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(title, pW),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildProductCard(
                '商品${index + 1}',
                'https://via.placeholder.com/76x76',
                pW,
                isSmall: true,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(PublicWidget pW, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(title, pW),
        Container(
          height: 239.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildProductCard(
                '商品${index + 1}',
                'https://via.placeholder.com/148x148',
                pW,
                isSmall: false,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid(PublicWidget pW, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(title, pW),
        Container(
          height: 112.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildCategoryCard('分类${index + 1}', pW);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, PublicWidget pW) {
    return Container(
      height: 38.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          Container(
            width: 20.w,
            height: 20.w,
            decoration: const BoxDecoration(
              color: Color(0xFFE0E0E0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_right,
              size: 14.w,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    String title,
    String imageUrl,
    PublicWidget pW, {
    required bool isSmall,
  }) {
    final cardWidth = isSmall ? 76.w : 148.w;
    final cardHeight = isSmall ? 104.h : 223.h;
    final imageSize = isSmall ? 76.w : 148.w;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: EdgeInsets.only(right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                'assets/images/Image.png',
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE0E0E0),
                    child: Center(
                      child: Text(
                        '图片',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (!isSmall) ...[
            pW.Box(h: 12.h),
            Text(
              '品牌名称',
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF666666)),
            ),
            pW.Box(h: 4.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF333333),
              ),
            ),
            pW.Box(h: 4.h),
            Text(
              '\$10.99',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFE74C3C),
              ),
            ),
          ] else ...[
            pW.Box(h: 8.h),
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF333333)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, PublicWidget pW) {
    return Container(
      width: 96.w,
      height: 96.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(
          'assets/images/Image.png',
          width: 96.w,
          height: 96.w,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE0E0E0),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF666666),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomTabBar(PublicWidget pW) {
    return Container(
      height: 78.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Column(
        children: [
          Container(
            height: 44.h,
            child: Row(
              children: [
                _buildTabItem(Icons.home, true, pW),
                _buildTabItem(Icons.explore, false, pW),
                _buildTabItem(Icons.shopping_cart, false, pW),
                _buildTabItem(Icons.notifications, false, pW),
                _buildTabItem(Icons.person, false, pW),
              ],
            ),
          ),
          Container(
            height: 34.h,
            child: Center(
              child: Container(
                width: 134.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF000000),
                  borderRadius: BorderRadius.circular(2.5.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, bool isSelected, PublicWidget pW) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // 处理标签点击
        },
        child: Container(
          height: 44.h,
          child: Icon(
            icon,
            size: 24.w,
            color: isSelected
                ? const Color(0xFF1976D2)
                : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}
