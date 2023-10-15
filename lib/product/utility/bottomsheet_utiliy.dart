import 'package:flutter/material.dart';

import '../model/comment_model.dart';

class BottomSheetUtility {
  static void showBottomSheet(BuildContext context, List<CommentModel> comments) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {},
            child: Text(comments[index].comment),
          ),
        );
      },
    );
  }
}
