import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosun_fi_windows/gen/assets.gen.dart';
import 'package:rosun_fi_windows/util/f_route.dart';

class MainPageCtrl extends GetxController {
  double deawWidth = 250.w;
  ScrollController scrollController = ScrollController();
  double backWidth = 65.w;
  bool hasDraw = false;
  double turns = 0;

  List<CategoryItem> categoryList = [
    CategoryItem(
      name: '放松空间',
      image: Assets.images.lampObject.image(),
      desc: '冥想音乐、自然白噪音、助眠故事，治愈你的心灵',
      onTap: (){
        FRoute.push(FRoute.relaxationSpace);
      }
    ),
    CategoryItem(
      name: '社交广场',
      image: Assets.images.pig.image(),
      desc: '遇见有趣的人，分享生活点滴，建立真实连接',
      onTap: (){
      }
    ),
    CategoryItem(
      name: '娱乐天地',
      image: Assets.images.books.image(),
      desc: '热门话题、搞笑段子、趣味挑战，让生活更有趣',
      onTap: (){
      }
    ),
    CategoryItem(
      name: '游戏乐园',
      image: Assets.images.computer.image(),
      desc: '休闲小游戏、竞技对战、好友PK，随时开玩',
      onTap: (){
      }
    ),
    CategoryItem(
      name: '音乐世界',
      image: Assets.images.pig.image(),
      desc: '发现新歌、创建歌单、音乐社交，用旋律连接彼此',
      onTap: (){
      }
    ),
    CategoryItem(
      name: '影音剧场',
      image: Assets.images.pig.image(),
      desc: '热门影视、精彩片段、影评讨论，一起追剧吧',
      onTap: (){
      }
    ),
    CategoryItem(
      name: '创作工坊',
      image: Assets.images.pig.image(),
      desc: '分享作品、学习技能、灵感碰撞，释放你的创造力',
      onTap: (){
      }
    ),
    CategoryItem(
      name: '探索发现',
      image: Assets.images.pig.image(),
      desc: '新奇事物、知识分享、生活技巧，每天都有新发现',
      onTap: (){
      }
    ),
  ];

  // 存储已初始化的 item 索引
  Set<int> initializedItems = {};

  void showDraw() {
    hasDraw = !hasDraw;
    scrollController.animateTo(
      hasDraw ? scrollController.position.maxScrollExtent : 0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    update();
  }
  scrollListener() {
    scrollController.addListener((){
      final offset = scrollController.offset;
      print("offset${offset}");
      if(1<offset && offset<270){
        turns = -0.5 + (offset/250.w)*0.5;
        backWidth = (offset/250.w)*145.w;
      }
      else if(offset>=270){
        hasDraw = true;
      }
      else if(offset<=1){
        hasDraw = false;
      }
      update();
    });
  }
  @override
  void onInit() {
    scrollListener();
    super.onInit();
    // 逐个初始化 item，每个 item 延迟不同的时间
    _initItemsWithDelay();
  }

  void _initItemsWithDelay() {
    for (int i = 0; i < categoryList.length; i++) {
      Future.delayed(
        Duration(milliseconds: 50 + i * 100), // 每个 item 延迟递增 100ms
        () {
          initializedItems.add(i);
          update();
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    // 清理逻辑
  }
}

class CategoryItem {
  String name ;
  Widget image;
  String desc;
  Function onTap;
  CategoryItem({required this.name, required this.image, required this.desc, required this.onTap});
}

