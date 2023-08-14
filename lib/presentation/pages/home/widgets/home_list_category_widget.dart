import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/get_all_category/get_all_category_bloc.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/item_category.dart';

class HomeListCategoryWidget extends StatelessWidget {
  const HomeListCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BlocBuilder<GetAllCategoryBloc, GetAllCategoryState>(
        builder: (context, state) {
          if (state is GetAllCategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetAllCategoryLoaded) {
            return ListView.builder(
              key: const PageStorageKey<String>('homeListCategory'),
              itemCount: state.data.data.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final category = state.data.data[index];

                return ItemCategory(
                  category: category,
                  index: index,
                );
              },
            );
          }

          if (state is GetAllCategoryError) {
            return Center(
              child: Text(state.messageError),
            );
          }

          return Container(height: 110);
        },
      ),
    );
  }
}
