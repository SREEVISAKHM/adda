// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:adda/model/selected_slots.dart';
import 'package:adda/providers/booking_provider.dart';
import 'package:adda/providers/confirm_view_provider.dart';
import 'package:adda/view/common/c_appbar.dart';
import 'package:adda/view/confirmation_screen/confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/facility_model.dart';
import '../../utils/dialoges.dart';
import '../common/custom_button.dart';

class BookingView extends ConsumerStatefulWidget {
  final List<FacilityModel> facilities;
  final int index;
  const BookingView({super.key, required this.facilities, required this.index});

  @override
  ConsumerState<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(bookingProvider).getDate(null);
      ref.watch(bookingProvider).getTime(null, null, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
          title: widget.facilities[widget.index].facilityName
              .replaceAll('\n', ' '),
          backButton: true),
      body: Column(
        children: [
          height(20),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Hero(
                tag: widget.facilities[widget.index].image,
                child: Image.asset(
                  widget.facilities[widget.index].image,
                  fit: BoxFit.fill,
                )),
          ),
          height(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomButton(
                  title: ref.watch(bookingProvider).dateValue,
                  headerText: 'Date',
                  onTap: () {
                    pickDate(context, ref);
                  },
                ),
                height(10),
                CustomButton(
                  title:
                      '${ref.watch(bookingProvider).startTimeValue}  ${ref.watch(bookingProvider).endTimeValue != '' ? '- ${ref.watch(bookingProvider).endTimeValue}' : ''}',
                  headerText: 'Time',
                  onTap: () {
                    if (ref.watch(bookingProvider).dateValue != 'Choose Date') {
                      pickTime(context, ref);
                    } else {
                      showToast('Choose date first');
                    }
                  },
                ),
                height(30),
                CustomButton(
                  title: 'Book Your Slot',
                  titleColor: Colors.white,
                  color: Colors.lightBlue,
                  onTap: () {
                    DateFormat format = DateFormat("hh:mm");
                    var bookingProvidervariable = ref.watch(bookingProvider);
                    if (bookingProvidervariable.dateValue == 'Choose Date' ||
                        bookingProvidervariable.startTimeValue ==
                            'Choose Time') {
                      showToast('Please choose Date And Time');
                    } else {
                      SelectedSlots tempSelectedSlot = SelectedSlots(
                          date: bookingProvidervariable.dateValue,
                          startTime: bookingProvidervariable.startTimeValue,
                          endTime: bookingProvidervariable.endTimeValue,
                          facility: widget.facilities[widget.index].facilityName
                              .replaceAll('\n', ' '));

                      var slotList =
                          ref.watch(confirmViewProvider).selectedSlots;

                      var check = slotList.indexWhere((val) =>
                          val.date == tempSelectedSlot.date &&
                          val.startTime == tempSelectedSlot.startTime &&
                          val.facility == tempSelectedSlot.facility);

                      if (check != -1) {
                        showToast(
                            'Slot is already booked , please choose another slot');
                      } else {
                        bool isOverrideEndTime = true;
                        String bookedTime = '';

                        for (var slot in slotList) {
                          if (slot.facility == tempSelectedSlot.facility &&
                              slot.date == tempSelectedSlot.date) {
                            if (format.parse(tempSelectedSlot.endTime).isAfter(format.parse(slot.startTime)) &&
                                    format
                                        .parse(tempSelectedSlot.startTime)
                                        .isBefore(
                                            format.parse(slot.startTime)) ||
                                format.parse(tempSelectedSlot.startTime).isAfter(format.parse(slot.endTime)) &&
                                    format
                                        .parse(tempSelectedSlot.endTime)
                                        .isAfter(format.parse(slot.endTime)) ||
                                format.parse(tempSelectedSlot.startTime).isAfter(
                                        format.parse(slot.startTime)) &&
                                    format.parse(slot.endTime).isAfter(format
                                        .parse(tempSelectedSlot.startTime)) ||
                                format.parse(slot.endTime).isAfter(format.parse(tempSelectedSlot.startTime)) &&
                                    format
                                        .parse(tempSelectedSlot.endTime)
                                        .isAfter(format.parse(slot.endTime))) {
                              log('hii');
                              bookedTime +=
                                  "${slot.startTime} -${slot.endTime} ,";

                              isOverrideEndTime = false;
                            }
                          } else {
                            isOverrideEndTime = true;
                          }
                        }
                        log('$isOverrideEndTime this');
                        if (isOverrideEndTime) {
                          ref.read(confirmViewProvider).getTotal(
                              bookingProvidervariable.startTimeValue,
                              bookingProvidervariable.endTimeValue,
                              widget.facilities[widget.index].hourlyPrice);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ConfirmationView(
                                facility: widget
                                    .facilities[widget.index].facilityName
                                    .replaceAll('\n', ' '),
                                date: bookingProvidervariable.dateValue,
                                time:
                                    '${bookingProvidervariable.startTimeValue} to ${bookingProvidervariable.endTimeValue}',
                                startTime:
                                    bookingProvidervariable.startTimeValue,
                                endTime: bookingProvidervariable.endTimeValue,
                              ),
                            ),
                          );
                        } else {
                          showToast(
                              'Slot is Already booked from  $bookedTime  please choose another slot');
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox width(double width) => SizedBox(
        width: width,
      );

  SizedBox height(double height) => SizedBox(
        height: height,
      );

  Future pickDate(BuildContext context, WidgetRef ref) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5));

    if (newDate != null) {
      ref.watch(bookingProvider).getDate(newDate);
    }
  }

  Future pickTime(BuildContext context, WidgetRef ref) async {
    final initialTime = TimeOfDay.now();

    TimeOfDay? newStartTime = await showTimePicker(
        context: context, initialTime: initialTime, helpText: 'Start Time');
    if (newStartTime != null) {
      final tempNewStartTime = toDouble(newStartTime);
      final tempInitialTime = toDouble(initialTime);

      while (tempNewStartTime < tempInitialTime) {
        newStartTime = null;
        showToast('Choose time ahead of current time');
        pickTime(context, ref);
        break;
      }
      pickEndTime(newStartTime, context, ref);
    }
  }

  Future pickEndTime(
      TimeOfDay? newStartTime, BuildContext context, WidgetRef ref) async {
    final initialEndTime =
        TimeOfDay(hour: newStartTime!.hour + 1, minute: newStartTime.minute);

    TimeOfDay? newEndTime = await showTimePicker(
        context: context, initialTime: initialEndTime, helpText: 'End Time');
    if (newEndTime != null) {
      final tempNewEndTime = toDouble(newEndTime);
      final tempInitialEndTime = toDouble(initialEndTime);

      while (tempNewEndTime < tempInitialEndTime) {
        newEndTime = null;
        while ((tempNewEndTime - tempInitialEndTime) < 1) {
          newEndTime = null;
          showToast('Choose time minimum of 1 hour diffrence');

          break;
        }

        pickEndTime(newStartTime, context, ref);
        break;
      }
    }
    ref.watch(bookingProvider).getTime(newStartTime, newEndTime, context);
  }
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
