import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:taskapp/constants/colors.dart';
import 'package:taskapp/models/date_model.dart';
import 'package:taskapp/screens/pending_screen/widgets/carousel/custom_dots_indicator.dart';
import 'package:taskapp/screens/pending_screen/widgets/date_card.dart';

class Carousel extends StatefulWidget {
  final List categories;
  int current;
  final Function(int) onCategoryChanged;

  Carousel({Key? key, required this.categories, required this.onCategoryChanged, required this.current})
      : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            initialPage: widget.current,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                widget.current = index;
              });
              widget.onCategoryChanged(index);
            },
          ),
          items: widget.categories.map<Widget>((i) => Builder(
            builder: (BuildContext context) {
              int index = widget.categories.indexOf(i);
              return DayCard(
                  cardColor: index % 2 != 0
                      ? AppColors.pink
                      : index % 3 != 0
                      ? AppColors.lightGreen
                      : AppColors.honeyYellow,
                  date: i,
              );
            },
          )).toList(),
        ),
        const SizedBox(height: 10),
        DotsIndicator(
          itemCount: widget.categories.length,
          currentIndex: widget.current,
        ),

      ],
    );
  }
}
