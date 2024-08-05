import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training_book_store/core/utils/app_colors.dart';
import 'package:training_book_store/core/utils/text_style.dart';
import 'package:training_book_store/features/home/data/model/product_model/product_model.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_cubit.dart';
import 'package:training_book_store/features/home/presentation/view_model/product_states.dart';
import 'package:training_book_store/features/home/presentation/widgets/home_widgets/best_seller_view.dart';

class NewArrivalView extends StatefulWidget {
  const NewArrivalView({
    super.key,
    required this.newArrival,
    //  required this.state,
  });

  final ProductModel newArrival;

  @override
  State<NewArrivalView> createState() => _NewArrivalViewState();
}

class _NewArrivalViewState extends State<NewArrivalView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().showNewsArrivals();
  }

  // final ProductStates state ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductStates>(builder: (context, state) {
      if (state is NewArrivalErrorState) {
        return Center(
          child: Container(
            height: 150,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: const [
                BoxShadow(
                    color: AppColors.grey,
                    blurRadius: 10,
                    offset: Offset(5, 5)),
              ],
              border: Border.all(color: AppColors.purple, width: 2.5),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 50,
                  color: AppColors.purple,
                ),
                const Gap(25),
                Text(
                  'Something went wrong',
                  style: getTitleStyle(),
                ),
              ],
            ),
          ),
        );
      } else if (state is NewArrivalLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ShowProductsList(
        widget: widget.newArrival,
      );
    });
  }
}