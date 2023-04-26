import 'package:adda/model/selected_slots.dart';
import 'package:adda/utils/dialoges.dart';
import 'package:adda/view/home/home.dart';
import 'package:flutter/material.dart';

import 'package:adda/view/common/c_appbar.dart';
import 'package:adda/view/common/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/confirm_view_provider.dart';

class ConfirmationView extends ConsumerWidget {
  final String facility, date, time, startTime;
  const ConfirmationView({
    Key? key,
    required this.time,
    required this.facility,
    required this.date,
    required this.startTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: const CommonAppBar(
          backButton: true,
          title: 'Confirm Booking',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              height(50),
              const Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Colors.green,
              ),
              height(100),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    decorationStyle: TextDecorationStyle.dashed,
                    height: 1.5,
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Hurray ! you have chosen the \n',
                    ),
                    TextSpan(
                      text: facility,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 22.0,
                      ),
                    ),
                    const TextSpan(
                      text: '\n on ',
                    ),
                    TextSpan(
                      text: date,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 22.0,
                      ),
                    ),
                    const TextSpan(
                      text: ' at\n',
                    ),
                    TextSpan(
                      text: time,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 22.0,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\nYour Total Cost Will Be : ${ref.watch(confirmViewProvider).total} Rs.',
                      style: const TextStyle(
                        height: 4,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 19.0,
                      ),
                    ),
                  ],
                ),
              ),
              height(25),
              CustomButton(
                title: 'Confirm',
                color: Colors.greenAccent,
                onTap: () {
                  ref.read(confirmViewProvider).addToSlots(SelectedSlots(
                      date: date,
                      startTime:
                          DateFormat("hh:mm").parse(startTime).hour.toString(),
                      facility: facility));
                  Navigator.popUntil(context, (route) {
                    if (route is MaterialPageRoute &&
                        route.builder(context) is Home) {
                      return true;
                    } else {
                      return false;
                    }
                  });

                  showToast('Booking Confirmed');
                },
              )
            ],
          ),
        ));
  }

  SizedBox width(double width) => SizedBox(
        width: width,
      );

  SizedBox height(double height) => SizedBox(
        height: height,
      );
}
