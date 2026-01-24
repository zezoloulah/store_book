import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_book/core/const/app_color.dart';
import 'package:store_book/core/utile/Custom_Text.dart';
import 'package:store_book/core/utile/custom_alert_dilog_error.dart';
import 'package:store_book/core/utile/custom_app_bar.dart';
import 'package:store_book/core/utile/custom_back_bottom.dart';
import 'package:store_book/core/utile/custom_bottom.dart';
import 'package:store_book/core/utile/custom_text_form_field.dart';
import 'package:store_book/features/check_out/data/model/governorate/governorate_model.dart';
import 'package:store_book/features/check_out/view_model/check_out/cubit/check_out_cubit.dart';
import 'package:store_book/features/check_out/view_model/get_governorate/cubit/get_governorate_cubit.dart';
import 'package:store_book/features/check_out/view_model/plase_order/cubit/place_order_cubit.dart';
import 'package:store_book/features/congrats/view/congrats_screen.dart';
import 'package:store_book/features/navigater_bar/view/navigator_screen.dart';

class CheckOutBody extends StatefulWidget {
  const CheckOutBody({super.key, required this.total});
  final String total;
  @override
  State<CheckOutBody> createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController governmentController = TextEditingController();
  GovernorateModel? selectedValue;
  @override
  void initState() {
    context.read<GetGovernorateCubit>().getGovernorate();
    context.read<CheckOutCubit>().checkOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: h * 0.05),
              Row(
                children: [
                  CustomBackBottom(),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 40),
                    child: CustomAppBar(title: "CheckOut", addIcon: false),
                  ),
                ],
              ),
              SizedBox(height: h * 0.07),
              CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter your name";
                  }
                  if (value.length < 7) {
                    return "name is short";
                  }
                  return null;
                },
                controller: nameController,
                title: "Full Name",
              ),
              SizedBox(height: h * 0.02),
              CustomTextFormField(
                controller: emailController,
                title: "Email",
                validator: (value) {
                  String emailPattern =
                      r"^[A-Za-z0-9]+([._%+-]?[A-Za-z0-9]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$";
                  RegExp regExp = RegExp(emailPattern);
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!regExp.hasMatch(value)) {
                    return "Please enter the value can use whit email";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.02),
              CustomTextFormField(
                controller: addressController,
                title: "Address",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your address";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.02),
              CustomTextFormField(
                controller: phoneController,
                title: "phone",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (value.length < 11) {
                    return "there is not phone";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.02),
              BlocBuilder<GetGovernorateCubit, GetGovernorateState>(
                builder: (context, state) {
                  if (state is GetGovernorateFailure) {
                    return CustomText(
                      title: state.errMassage,
                      hight: 0.05,
                      color: Colors.black,
                    );
                  }
                  if (state is GetGovernorateSuccess) {
                    var data = state.data.data;
                    final List<GovernorateModel> governorates = data;

                    ;
                    return DropdownButtonFormField<GovernorateModel>(
                      menuMaxHeight: 200,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.grayColor,
                        labelText: 'Governorate',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      value: selectedValue,
                      items: governorates.map((item) {
                        return DropdownMenuItem<GovernorateModel>(
                          value: item,
                          child: Text(item.governorateNameEn),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select the Governorate';
                        }
                        return null;
                      },
                    );
                  }
                  return Container(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: h * 0.25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: "total:",
                    hight: 0.03,
                    color: AppColor.darkerColor,
                  ),
                  BlocBuilder<CheckOutCubit, CheckOutState>(
                    builder: (context, state) {
                      if (state is CheckOutFailure) {
                        return CustomText(
                          title: state.errMassage,
                          hight: 0.01,
                          color: Colors.black,
                        );
                      }
                      if (state is CheckOutSuccess) {
                        var data = state.data.data.total;
                        return CustomText(
                          title: "₹${data}",
                          hight: 0.03,
                          color: Colors.black,
                        );
                      }
                      return CircularProgressIndicator(
                        color: AppColor.firstColor,
                      );
                    },
                  ),
                ],
              ),
              BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
                listener: (context, state) {
                  if (state is PlaceOrderFailure) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomAlertDialogError(errMassage: state.errMassage),
                    );
                  }
                  if (state is PlaceOrderSuccess) {
                    var d = state.data;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        onVisible: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigatorScreen(),
                            ),
                          );
                        },
                        content: Text('${d.message}'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PlaceOrderLoading) {
                    return CircularProgressIndicator(
                      color: AppColor.firstColor,
                    );
                  }
                  return CustomBottom(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        context.read<PlaceOrderCubit>().placeOrder(
                          selectedValue!.id,
                          nameController.text,
                          phoneController.text,
                          emailController.text,
                          addressController.text,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CongratsScreen(),
                          ),
                        );
                      }
                    },
                    title: "Submit Order",
                    titleColor: AppColor.whiteColor,
                    bottomColor: AppColor.firstColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
