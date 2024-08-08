import 'package:flutter/material.dart';
import 'package:neversitup_app/core/extension/context_extension.dart';
import 'package:neversitup_app/core/extension/size_extension.dart';
import 'package:rxcache_network_image/rxcache_network_image.dart';

import '../../core/component/sliver_box.dart';
import '../../core/constant.dart';
import '../domain/models/department/response/department.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({
    super.key,
    required this.data,
    required this.onTab,
  });

  final Department data;
  final void Function() onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Stack(
        children: [
          ///image
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Opacity(
              opacity: .9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  kDefaultPadding / 2,
                ),
                child: RxImage.cacheNetwork(
                  url: data.imageUrl,
                  fit: BoxFit.cover,
                  width: 26.w,
                  height: double.infinity,
                  cacheHeight: kDecodeImageSmall,
                  cacheWidth: kDecodeImageSmall,
                ),
              ),
            ),
          ),

          ///name
          Positioned(
            top: kDefaultPadding / 1.2,
            right: kDefaultPadding,
            child: Text(
              data.name ?? 'N/A',
              style: context.theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
