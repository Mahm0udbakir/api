import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalel/core/models/data_model.dart';
import 'package:dalel/core/utils/colors.dart';
import 'package:dalel/core/utils/text_styles.dart';
import 'package:dalel/core/widgets/custom_shrimmer.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, this.model});

  final DataModel? model;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 170,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: MyAppColors.grey,
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: Column(
        children: [
          Container(
            height: 124,
            width: 95,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: model?.image == null
                ? const CustomShrimmer(
                    shimmerContainer: SizedBox(
                      height: 124,
                      width: 95,
                       ),
                  )
                : CachedNetworkImage(
                    imageUrl: model!.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CustomShrimmer(
                      shimmerContainer: Container(
                        height: 124,
                        width: 95,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
          Text(
            model?.name ?? 'Unknown Period',
            style: MyAppTextStyles.poppins500size16.copyWith(
              color: MyAppColors.deepBrown,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
