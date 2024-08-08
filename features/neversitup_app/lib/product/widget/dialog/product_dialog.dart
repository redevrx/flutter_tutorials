import 'package:flutter/material.dart';
import 'package:neversitup_app/core/constant.dart';
import 'package:neversitup_app/core/extension/context_extension.dart';
import 'package:neversitup_app/core/extension/size_extension.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';

Future<void> showProductDialog(
    {required BuildContext context, required Product data}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    pageBuilder: (context, animation, secondaryAnimation) {
      return GestureDetector(
        key: const Key("product dialog"),
        onTap: Navigator.of(context).pop,
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding,
                horizontal: kDefaultPadding / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultPadding),
                color: Colors.white,
              ),
              width: 70.w,
              height: 26.h,
              child: Column(
                children: [
                  ///title
                  Text(
                    "Product Description",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      data.desc ?? 'N/A',
                      style: context.theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  const Divider(),
                  ElevatedButton(
                    key: const Key('close dialog'),
                    onPressed: Navigator.of(context).pop,
                    child: const Text("Close"),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
