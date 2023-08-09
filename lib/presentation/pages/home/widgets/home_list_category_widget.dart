import 'package:fic6_fe_beliyuk/bloc/get_all_category/get_all_category_bloc.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListCategoryWidget extends StatefulWidget {
  const HomeListCategoryWidget({super.key});

  @override
  State<HomeListCategoryWidget> createState() => _HomeListCategoryWidgetState();
}

class _HomeListCategoryWidgetState extends State<HomeListCategoryWidget> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllCategoryBloc>().add(DoGetAllCategoryEvent());
  }

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
              itemCount: state.data.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = state.data.data[index];

                return Container(
                  width: 110,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 6),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${GlobalVariables.baseUrl}${category.attributes.logo.data.attributes.url}'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            category.attributes.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is GetAllCategoryError) {
            return Center(
              child: Text(state.messageError),
            );
          }

          return const Center(
            child: Text('Failed get data category !'),
          );
        },
      ),
    );
  }
}
