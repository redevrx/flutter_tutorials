import 'package:flutter/material.dart';
import 'package:neversitup_app/core/extension/context_extension.dart';
import 'package:neversitup_app/core/extension/size_extension.dart';
import 'package:neversitup_app/product/widget/dialog/product_dialog.dart';
import 'package:rxcache_network_image/rxcache_network_image.dart';

import '../../core/constant.dart';
import '../domain/models/product/response/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.data,
  });

  final Product data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('product card ${data.id}'),
      onTap: () async {
        ///
        await showProductDialog(context: context, data: data);
      },
      child: Container(
        margin: const EdgeInsets.all(kDefaultPadding / 2),
        height: 20.h,
        width: 40.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kDefaultPadding),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.12),
                offset: const Offset(0, 8),
                blurRadius: 5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding),
                  topRight: Radius.circular(kDefaultPadding),
                ),
                child: RxImage.cacheNetwork(
                  url: data.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  cacheWidth: kMediumDecodeImageWidth,
                  cacheHeight: kMediumDecodeImageWidth,
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    child: Text(
                      data.name ?? "N/A",
                      style: context.theme.textTheme.bodySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 2),
                    child: Text(
                      data.desc ?? "N/A",
                      style: context.theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.all(kDefaultPadding / 2),
                        child: Text(
                          data.price ?? "N/A",
                          style: context.theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
