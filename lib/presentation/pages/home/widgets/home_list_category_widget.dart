import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/domain/entities/category.dart';
import 'package:beliyuk/presentation/blocs/home/home_bloc.dart';
import 'package:beliyuk/presentation/pages/home/widgets/item_category.dart';

class HomeListCategoryWidget extends StatelessWidget {
  const HomeListCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.categoriesState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.categoriesState == RequestState.loaded &&
              state.categories.isNotEmpty) {
            return ListView.builder(
              key: const PageStorageKey<String>('homeListCategory'),
              itemCount: state.categories.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Category category = state.categories[index];

                return ItemCategory(
                  category: category,
                  index: index,
                );
              },
            );
          }

          if (state.categoriesState == RequestState.error) {
            return Center(
              child: Text(state.categoriesMessage),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
