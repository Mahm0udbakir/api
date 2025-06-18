import 'package:api/utils/colors.dart';
import 'package:api/utils/text_styles.dart';
import 'package:api/widgets/custom_shrimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    this.model,
  });
  final DataModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 196,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 48,
              width: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                model?.name ?? 'Unknown Period',
                style: MyAppTextStyles.poppins500size16.copyWith(
                  color: MyAppColors.deepBrown,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 64,
              width: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: model?.image == null
                  ? const CustomShrimmer()
                  : CachedNetworkImage(
                      imageUrl: model!.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CustomShrimmer(
                        shimmerContainer: Container(
                          height: 64,
                          width: 47,
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
          ],
        ),
      ),
    );
  }
}
