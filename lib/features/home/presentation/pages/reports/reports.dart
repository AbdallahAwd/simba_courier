import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:simba_courier/core/resourses/strings.dart';
import 'package:simba_courier/core/resourses/styles.dart';
import 'package:simba_courier/features/home/presentation/cubit/home_cubit.dart';
import 'package:simba_courier/features/login_home/presentation/widgets/refister_form.dart';

import '../../../../../core/services/cache.dart';
import '../../../../../core/utils/button.dart';
import '../../../../../core/utils/pdf_generator.dart';
import '../../../../../core/utils/pdf_model.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  var fromDateController = TextEditingController();

  var toDateController = TextEditingController();

  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is PickError) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error.message),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                RegisterForm(
                    text: AppStrings.from_date,
                    keyType: TextInputType.datetime,
                    controller: fromDateController,
                    icona: Icons.date_range,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(
                              DateTime.now().year, DateTime.now().month - 1, 1),
                          firstDate: DateTime(2021),
                          lastDate: DateTime.now());
                      fromDateController.text =
                          '${selectedDate!.year}-${selectedDate.month}-${selectedDate.day}';
                    },
                    hint: AppStrings.from_date),
                const SizedBox(
                  height: 20,
                ),
                RegisterForm(
                    text: AppStrings.to_date,
                    keyType: TextInputType.datetime,
                    controller: toDateController,
                    icona: Icons.date_range_outlined,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      toDateController.text =
                          '${selectedDate!.year}-${selectedDate.month}-${selectedDate.day}';
                    },
                    hint: AppStrings.to_date),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    DefButton(
                        text: AppStrings.generate,
                        isLoading: state is GenerateLoading,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            HomeCubit.get(context).getReport(
                                fromDate: fromDateController.text,
                                toDate: toDateController.text);
                          }
                        },
                        size: const Size(165, 47))
                  ],
                ),
                const Spacer(),
                if (state is Generated)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 18,
                          ),
                          label: const Text(
                            AppStrings.send_to_email,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.monst,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 47),
                            maximumSize: const Size(150, 47),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(
                                    color: Colors.black, width: 0.5)),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (conetxt) {
                                  return BlocConsumer<HomeCubit, HomeState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: Form(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              RegisterForm(
                                                  text: AppStrings.email,
                                                  keyType: TextInputType
                                                      .emailAddress,
                                                  icona: Icons.email,
                                                  controller: emailController,
                                                  hint: AppStrings.email),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  if (state is Sent)
                                                    Lottie.asset(
                                                        AppAssets.checked,
                                                        repeat: false,
                                                        width: 47,
                                                        height: 47),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  if (state is Sent)
                                                    const Text(
                                                      AppStrings.done,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: FontFamily
                                                              .monstAlt,
                                                          fontSize: 18),
                                                    ),
                                                  const Spacer(),
                                                  DefButton(
                                                      text: AppStrings.send,
                                                      isLoading:
                                                          state is Sendloading,
                                                      size: const Size(165, 47),
                                                      onTap: () async {
                                                        if (emailController
                                                            .text.isNotEmpty) {
                                                          PdfModel pdfModel = PdfModel(
                                                              customerName:
                                                                  Cache.getData(
                                                                      key:
                                                                          'name'),
                                                              phone: Cache.getData(
                                                                  key: 'phone'),
                                                              date:
                                                                  '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
                                                              shipment:
                                                                  HomeCubit.get(
                                                                          context)
                                                                      .report);
                                                          final pdfFile =
                                                              await PdfReportApi()
                                                                  .generate(
                                                                      pdfModel);
                                                          PdfApi.openFile(
                                                              pdfFile);
                                                        }
                                                      }),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.download_sharp,
                            color: Colors.black,
                            size: 18,
                          ),
                          label: const Text(
                            AppStrings.download_pdf,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.monst,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 47),
                            maximumSize: const Size(160, 47),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(
                                    color: Colors.black, width: 0.5)),
                          ),
                          onPressed: () async {
                            PdfModel pdfModel = PdfModel(
                                customerName: Cache.getData(key: 'name'),
                                phone: Cache.getData(key: 'phone'),
                                date:
                                    '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
                                shipment: HomeCubit.get(context).report);
                            final pdfFile =
                                await PdfReportApi().generate(pdfModel);
                            PdfApi.openFile(pdfFile);
                          },
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
