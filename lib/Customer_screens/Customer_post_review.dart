import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomerPostReview extends StatefulWidget {
  // const CustomerPostReview({Key? key}) : super(key: key);

  @override
  State<CustomerPostReview> createState() => _CustomerPostReviewState();
}

class _CustomerPostReviewState extends State<CustomerPostReview> {
  double starRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Leave A Review",
        ),
        RatingBar.builder(
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              starRating = rating;
            }
        ),
        TextFormField(

        )
      ],
    );
  }
}
