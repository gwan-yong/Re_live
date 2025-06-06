import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_live/widget/schedule/upcoming_scheduled_list_items.dart';
import '../../controller/card_carousel_controller.dart';
import 'completed_scheduled_list_items.dart';
import 'journal_card.dart';

class CardCircularCarousel extends StatefulWidget {
  final double scale;
  final double cardPadding;

  const CardCircularCarousel({
    Key? key,
    required this.scale,
    required this.cardPadding,
  }) : super(key: key);

  @override
  State<CardCircularCarousel> createState() => _CardCircularCarouselState();
}

class _CardCircularCarouselState extends State<CardCircularCarousel> {
  final ScrollController _scrollController = ScrollController();

  late double screenWidth;
  double cardWidth = 0;
  double cardCenterOffset = 0;
  double cardSpacing = 0 ;

  List<Widget> items1 = [];
  List<Widget> items2 = [];
  Widget? item3;
  List<Widget> combinedItems = [];
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _loadItems();
    CardCarouselController.to.setScrollController(_scrollController);

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        CardCarouselController.to.syncScrollToAngle(_scrollController.offset);
      }
    });
  }

  void _loadItems() {
    if (!mounted) return;
    items1 = CompletedScheduledListItems.build();
    items2 = UpcomingScheduledListItems.build(context);
    item3 = JournalCard();

    if (items1.isEmpty && items2.isEmpty) {
      combinedItems = [];
    } else if (items1.isNotEmpty && items2.isEmpty && item3 != null) {
      combinedItems = [...items1, item3!];
    } else {
      combinedItems = [...items1, ...items2];
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          int indexToScroll = 0;
          if (items2.isNotEmpty) {
            indexToScroll = items1.length;
          } else if (items2.isEmpty && items1.isNotEmpty && item3 != null) {
            indexToScroll = combinedItems.length - 1;
          }
          scrollToIndex(indexToScroll + 1, 700);
          print("scroll1");
        }
    });


  }

  int getCenterIndex() {
    if (!_scrollController.hasClients || cardSpacing == 0) return 0;
    if (_scrollController.hasClients) {
      CardCarouselController.to.updateMaxExtent(_scrollController.position.maxScrollExtent);
    }
    double scrollOffset = _scrollController.offset;
    if (scrollOffset < cardCenterOffset) return 0;

    for (int i = 1; i < combinedItems.length; i++) {
      double start = cardCenterOffset + (cardSpacing+CardCarouselController.to.cardPadding.value) * (i - 1);
      double end = cardCenterOffset + (cardSpacing+CardCarouselController.to.cardPadding.value) * i;
      if (scrollOffset >= start && scrollOffset < end) return i;
    }

    return combinedItems.length - 1;
  }

  double getYOffsetForIndex(int index, int centerIndex) {
    int relativeIndex = index - centerIndex;
    double radius = 150.0;
    double normalized = (relativeIndex / 4.0).clamp(-1.0, 1.0);
    return -sin((1 - normalized.abs()) * pi / 2) * radius + 100;
  }

  double getAngleForIndex(int index, int centerIndex) {
    int relativeIndex = index - centerIndex;
    double maxAngle = pi / 6;
    double normalized = (relativeIndex / 5.0).clamp(-1.0, 1.0);
    return sin(normalized * pi / 2) * maxAngle;
  }

  void scrollToIndex(int index, int duration) {
    if (_scrollController.hasClients) {
      CardCarouselController.to.updateMaxExtent(_scrollController.position.maxScrollExtent);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
        double targetOffset = index <= 1 ? 0 : (cardSpacing + CardCarouselController.to.cardPadding.value) * (index - 1);

        // duration이 0일 때 jumpTo, 그 외에는 animateTo
        if (duration <= 0) {
          _scrollController.jumpTo(targetOffset);
        } else {
          _scrollController.animateTo(
            targetOffset,
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOut,
          );
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        CardCarouselController.to.updateMaxExtent(_scrollController.position.maxScrollExtent);
      }
    });

    if (combinedItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 150),
        child: Center(
          child: Text(
            '등록된 일정이 없습니다',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    final baseScreenWidth = MediaQuery.of(context).size.width;

    if (cardWidth == 0.0) {
      cardWidth = baseScreenWidth / 2.5;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: CardCarouselController.to.cardCarouselScale.value,
        end: widget.scale,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      onEnd: () {
        isAnimating = false;

      },
      builder: (context, animatedScale, child) {
        scrollToIndex(CardCarouselController.to.lastIndex.value, 0); //scroll2
        print("scroll2 ${CardCarouselController.to.lastIndex.value}");
        isAnimating = true;
        screenWidth = baseScreenWidth * animatedScale;
        cardWidth = screenWidth / 2.5;
        double cardHeight = cardWidth * 24 / 13;
        cardCenterOffset = cardWidth / 2 - 10;
        cardSpacing = cardWidth - 20;
        double leftPadding = baseScreenWidth / 2 - cardWidth / 2;

        return Column(
          children: [
            const SizedBox(height: 70),
            NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                Future.delayed(const Duration(milliseconds: 20), () {
                  if(isAnimating!){
                    final index = getCenterIndex();
                    scrollToIndex(index + 1, 500);
                    CardCarouselController.to.lastIndex.value = index + 1;
                    print("scroll3 ${CardCarouselController.to.lastIndex.value}"); //scroll3
                  }
                });
                return false;
              },
              child: Padding(
                padding: combinedItems.length == 1
                    ? const EdgeInsets.only(left: 0)
                    : EdgeInsets.symmetric(horizontal: leftPadding),
                child: AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, child) {
                    int centerIndex = getCenterIndex();
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      physics: const _CustomScrollPhysics(),
                      clipBehavior: Clip.none,
                      child: Row(
                        children: List.generate(combinedItems.length, (index) {
                          double xOffset = -index * 30.0;
                          double yOffset = getYOffsetForIndex(index, centerIndex);
                          double angle = getAngleForIndex(index, centerIndex);

                          return TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: yOffset),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutBack,
                            builder: (context, animatedYOffset, child) {
                              return TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0, end: angle),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutBack,
                                builder: (context, animatedAngle, child) {
                                  return Transform.translate(
                                    offset: Offset(xOffset, animatedYOffset),
                                    child: Transform.rotate(
                                      angle: animatedAngle,
                                      child: child,
                                    ),
                                  );
                                },
                                child: GetBuilder<CardCarouselController>(
                                    builder: (controller) {
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: CardCarouselController.to.cardPadding.value,
                                      end: widget.cardPadding,
                                    ),
                                    duration: const Duration(milliseconds: 900),
                                    curve: Curves.easeOutBack,
                                    onEnd: () {
                                      isAnimating = false;
                                    },
                                    builder: (context, animatedPadding, child) {
                                      /*scrollToIndex(CardCarouselController.to.lastIndex.value, 0);
                                      print("scroll4 ${CardCarouselController.to.lastIndex.value}"); //scroll4*/
                                      final safePadding = animatedPadding.clamp(0.0, double.infinity);
                                      isAnimating = true;
                                      return Padding(
                                        padding: EdgeInsets.only(right: safePadding),
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Center(
                                            child: SizedBox(
                                              height: cardHeight,
                                              width: cardWidth,
                                              child: combinedItems[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              );
                            },
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CustomScrollPhysics extends ClampingScrollPhysics {
  const _CustomScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  _CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double get dragStartDistanceMotionThreshold => 3.0;

  @override
  double get minFlingVelocity => 30.0;

  @override
  double get maxFlingVelocity => 800.0;

  @override
  double get flingVelocity => 100.0;
}