import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class PostItemWidget extends StatefulWidget {
  final PostEntity post;
  const PostItemWidget({super.key, required this.post});

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: ColorPallet.lowBackGround,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () => Get.toNamed(editOrCreatePostRoute, arguments: widget.post),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: _featuredImage(),
        title: Text(widget.post.title),
        subtitle: _subtitle(),
        trailing: Text(widget.post.date.toPersianDate()),
      ),
    );
  }

  Widget _featuredImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
      ),
      width: 50,
      height: 50,
      child: CachedNetworkImage(
        imageUrl:
            widget.post.featureMediaLink.replaceAll("localhost", "192.168.1.2"),
        fit: BoxFit.cover,
        errorListener: (value) {},
        errorWidget: (context, error, stackTrace) => const Icon(Icons.image),
      ),
    );
  }

  Column _subtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _authorName(),
        _status(),
      ].withGapInBetween(5),
    );
  }

  Text _authorName() => Text("توسط: ${widget.post.authorName}");

  Text _status() {
    return Text(
      key: const Key("status_text"),
      widget.post.status.translate(),
      style: TextStyle(color: _colorBasedOnStatus),
    );
  }

  Color get _colorBasedOnStatus {
    switch (widget.post.status) {
      case PostStatusEnum.publish:
        return ColorPallet.lightGreen;

      case PostStatusEnum.pending:
        return ColorPallet.yellow;

      case PostStatusEnum.draft:
        return ColorPallet.yellowishGreen;

      case PostStatusEnum.trash:
        return ColorPallet.crimson;

      default:
        return ColorPallet.blue;
    }
  }
}
