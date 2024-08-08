import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neversitup_app/core/component/sliver_box.dart';
import 'package:neversitup_app/core/constant.dart';
import 'package:neversitup_app/core/extension/context_extension.dart';
import 'package:neversitup_app/core/extension/size_extension.dart';
import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';
import 'package:neversitup_app/product/domain/product_provider/event/product_event.dart';
import 'package:neversitup_app/product/domain/product_provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../widget/department_card.dart';
import '../widget/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final ProductProvider provider;
  late final ValueNotifier<String> departmentName;
  bool isFirst = true;

  @override
  void initState() {
    departmentName = ValueNotifier('');
    provider = context.read();
    provider.onEvent(GetDepartmentEvent());
    super.initState();
  }

  @override
  void dispose() {
    provider.close();
    departmentName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ///tool bar
          buildGapHeight(),

          ///carousel title,
          buildTitleDepartment(context),

          ///carousel slider
          buildCarouselDepartment(),

          ///department name
          buildTitleSelectDepartment(),

          ///product list
          buildProductStream(),

          ///gap bottom
          buildGapHeight(),
        ],
      ),
    );
  }

  Consumer<ProductProvider> buildProductStream() {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return StreamBuilder(
          stream: provider.productStream,
          builder: (context, snapshot) {
            final mResponse = snapshot.data;

            if (mResponse != null && mResponse.isNotEmpty) {
              return buildProductList(mResponse);
            }

            if (mResponse == null) {
              ///data not found
              return buildDataNotFound(context);
            }

            return buildLoading();
          },
        );
      },
    );
  }

  SliverGrid buildProductList(List<Product> mResponse) {
    return SliverGrid(
      key: const Key("product list"),
      delegate: SliverChildBuilderDelegate(
        childCount: mResponse.length,
        (context, index) {
          final data = mResponse[index];
          return ProductCard(data: data);
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  SliverBox buildTitleSelectDepartment() {
    return SliverBox(
      child: Padding(
        padding: const EdgeInsets.all(
          kDefaultPadding,
        ),
        child: ValueListenableBuilder(
          valueListenable: departmentName,
          builder: (context, value, child) => Text(
            "Product list: ${departmentName.value}",
            style: context.theme.textTheme.titleSmall,
          ),
        ),
      ),
    );
  }

  Consumer<ProductProvider> buildCarouselDepartment() {
    return Consumer(
      builder: (context, value, child) {
        return StreamBuilder(
          stream: provider.departmentStream,
          builder: (context, snapshot) {
            final mResponse = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildLoading();
            }
            if (mResponse != null && mResponse.isNotEmpty) {
              scheduleMicrotask(() {
                if (isFirst) {
                  isFirst = false;
                  departmentName.value = mResponse.firstOrNull?.name ?? '';
                }
              });
              return buildCarouselList(mResponse);
            }

            if (mResponse == null) {
              ///data not found
              return buildDataNotFound(context);
            }

            if (mResponse.isEmpty) {
              ///data not found
              return buildDataNotFound(context);
            }

            return const SliverToBoxAdapter();
          },
        );
      },
    );
  }

  SliverBox buildCarouselList(List<Department> mResponse) {
    return SliverBox(
      height: 13.h,
      child: ListView.builder(
        key: const Key("carousel list"),
        scrollDirection: Axis.horizontal,
        itemCount: mResponse.length,
        itemBuilder: (context, index) {
          final data = mResponse[index];
          return DepartmentCard(
            data: data,
            onTab: () {
              scheduleMicrotask(() {
                departmentName.value = data.name ?? '';
                provider.onEvent(GetProductEvent(id: data.id ?? ''));
              });
            },
          );
        },
      ),
    );
  }

  SliverBox buildLoading() {
    return const SliverBox(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: CircularProgressIndicator(),
        ),
      ],
    ));
  }

  SliverBox buildDataNotFound(BuildContext context) {
    return SliverBox(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            "Data not found",
            style: context.theme.textTheme.titleSmall,
          ),
        ),
      ],
    ));
  }

  SliverBox buildTitleDepartment(BuildContext context) {
    return SliverBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Text(
          'Department Carousel',
          style: context.theme.textTheme.titleMedium,
        ),
      ),
    );
  }

  SliverBox buildGapHeight() => const SliverBox(
          child: SizedBox(
        height: kToolbarHeight,
      ));
}
