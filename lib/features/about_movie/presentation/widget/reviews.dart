import 'package:filmcrate/config/constants/app_color_theme.dart';
import 'package:filmcrate/config/constants/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewsView extends ConsumerStatefulWidget {
  const ReviewsView({
    Key? key,
    required this.assetImage,
    required this.name,
    required this.reviewText,
    required this.rating, // Add rating parameter here.
    required this.ref,
    required this.likes,
    required this.likeReview,
    required this.onLikeReview,
    required this.isUser,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final String assetImage;
  final String name;
  final String reviewText;
  final int rating; // Add rating parameter here.
  final WidgetRef ref;
  final String likes;
  final bool likeReview;
  final Function(bool) onLikeReview;
  final bool isUser;
  final Function onEdit;
  final Function onDelete;

  @override
  ConsumerState<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends ConsumerState<ReviewsView> {
  int rating = 0;

  @override
  void initState() {
    super.initState();
    rating = widget.rating; // Use the rating from the constructor.
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final bool isRatingSet = rating != 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: isTablet ? 35 : 22,
          child: ClipOval(
            child: Image.network(
              widget.assetImage,
              fit: BoxFit.cover,
              width: isTablet ? 80.0 : 40.0,
              height: isTablet ? 80.0 : 40.0,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: isTablet ? 38 : 25,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff9DB2BF),
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  widget.reviewText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: isTablet ? 20 : 12,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Call the callback function to toggle the likeReview status.
                            widget.onLikeReview(!widget.likeReview);
                          },
                          icon: Icon(
                            widget.likeReview
                                ? CustomIcon.heart_1
                                : CustomIcon.heart,
                            color: AppColors.bodyColors,
                            size: isTablet ? 25 : 14,
                          ),
                        ),
                        Text(
                          widget.likes,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: isTablet ? 18 : 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.isUser
                            ? IconButton(
                                onPressed: () {
                                  widget.onDelete();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: isTablet ? 25 : 15,
                                  color: Colors.red,
                                ),
                              )
                            : Container(),
                        widget.isUser
                            ? IconButton(
                                onPressed: () {
                                  widget.onEdit();
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: isTablet ? 25 : 15,
                                  color: AppColors.bodyColors,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            for (int i = 0; i < 5; i++)
              GestureDetector(
                child: Icon(
                  Icons.star,
                  size: isTablet ? 25 : 15,
                  color: (i < rating) ? Colors.green : Colors.grey,
                ),
                onTap: () {
                  if (!isRatingSet) {
                    setState(() {
                      rating = i + 1;
                    });
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}
