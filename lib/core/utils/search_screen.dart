import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simba_courier/core/resourses/color.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';
import 'package:simba_courier/features/home/presentation/widgets/pending_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    HomeCubit.get(context).shipment = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CupertinoSearchTextField(
          padding: const EdgeInsets.all(8),
          controller: controller,
          onSubmitted: (val) {
            HomeCubit.get(context).getPickupShipment(val);
          },
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is PickError) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error.message),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                onPressed: () {
                  HomeCubit.get(context).getPickupShipment(controller.text);
                },
                label: 'Retry',
                textColor: Colors.white,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is! PickDLoading) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return PendingContainer(
                  isDetails: true,
                  shipment: HomeCubit.get(context).shipment![index],
                  pickUpEntity: HomeCubit.get(context).verPickUp![index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: HomeCubit.get(context).shipment!.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
