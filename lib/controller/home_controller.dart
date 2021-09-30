import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  //Variable necesarias para instanciadas para hacer uso de un servicio
  final googleSignIn = GoogleSignIn();
  final log = GetStorage();

  //variables que muestran la respuesta en los TextField
  String dateOne = '', dateTwo = '', answer = '';

  //Varaibles para obtener las fechas actuales
  DateTime dateInputOne = DateTime.now();
  DateTime dateInputTwo = DateTime.now();

  //variables para obtener la hora actual
  TimeOfDay timeOne = TimeOfDay.now();
  TimeOfDay timeTwo = TimeOfDay.now();

  //variable para indicar si la fecha 2 es menor a la fecha 1
  int minuteNegative = 0;

//Método para formatear la fecha y mostrar en los TextField
  String _formatter(DateTime date) {
    DateFormat format = DateFormat('dd-MM-yyyy H:mm a');
    return format.format(date);
  }

//Método para recolectar las 2 fechas y hours establecidas por el usuario en UI
  Future datePresent(BuildContext context, int option) async {
    switch (option) {
      case 0:
        await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now())
            .then(
          (value) async {
            if (value == null) {
              return;
            } else {
              dateInputOne = value;
              final now = DateTime.now();
              await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay(hour: now.hour, minute: now.minute))
                  .then((value) {
                if (value == null) {
                  return;
                } else {
                  timeOne = value;
                  DateTime date = DateTime(
                      dateInputOne.year,
                      dateInputOne.month,
                      dateInputOne.day,
                      timeOne.hour,
                      timeOne.minute);
                  dateInputOne = date;
                  dateOne = _formatter(date);
                }
              });
            }
          },
        );
        update();
        break;
      case 1:
        await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now())
            .then(
          (value) async {
            if (value == null) {
              return;
            } else {
              dateInputTwo = value;
              final now = DateTime.now();
              await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay(hour: now.hour, minute: now.minute))
                  .then((value) {
                if (value == null) {
                  return;
                } else {
                  timeTwo = value;
                  DateTime date = DateTime(
                      dateInputTwo.year,
                      dateInputTwo.month,
                      dateInputTwo.day,
                      timeTwo.hour,
                      timeTwo.minute);
                  dateInputTwo = date;
                  dateTwo = _formatter(date);
                }
              });
            }
          },
        );

        update();
        break;
      default:
    }
  }

//Método para obtener la diferencia entre las fechas indicadas
  String difference() {
    final date1 = dateInputOne;
    final date2 = dateInputTwo;
    String year = '0';
    String days = '0';
    String weeks = '0';
    String months = '0';
    String hours = '0';
    String minutes = '0';
    List<String> data = [];
    String answer = '';

//Validaciones para mostrar la diferencia
    bool hM = false, dHM = false, sDHM = false, mSDHM = false, aMSDHM = false;

    minutes = (date2.difference(date1).inMinutes).toString();
    minuteNegative = date2.difference(date1).inMinutes;

    if ((int.parse(minutes).abs()) >= 60) {
      hours = (double.parse(minutes).abs() / 60).toString();
      data = hours.split('.');
      minutes = data[1]; //00
      data[1] = '0.' + data[1];
      minutes = (double.parse(data[1]) * 60).round().toString();
      if (int.parse(data[0]) >= 24) {
        hM = true;
        days = (double.parse(data[0]) / 24).toString();
        data = days.split('.');
        data[1] = '0.' + data[1];
        hours = (double.parse(data[1]) * 24).round().toString();
        if (int.parse(data[0]) >= 7) {
          dHM = true;
          weeks = (double.parse(data[0]) / 7).toString();
          data = weeks.split('.');
          data[1] = '0.${data[1]}';
          days = (double.parse(data[1]) * 7).round().toString(); //00
          if (int.parse(data[0]) > 4.3) {
            sDHM = true;
            months = (double.parse(data[0]) / 4.3).toString();
            data = months.split('.');
            data[1] = '0.${data[1]}';
            weeks = (double.parse(data[1]) * 4.3).round().toString();
            if (int.parse(data[0]) >= 12) {
              mSDHM = true;
              year = (double.parse(data[0]) / 12).toString();
              data = year.split('.');
              data[1] = '0.${data[1]}';
              year = data[0];
              months = (double.parse(data[1]) * 12).round().toString();
              aMSDHM = true;
            } else {
              months = data[0].toString();
              mSDHM = true;
            }
          } else {
            weeks = data[0].toString();
            sDHM = true;
          }
        } else {
          days = data[0].toString();
          dHM = true;
        }
      } else {
        hours = data[0].toString();
        hM = true;
      }
    } else {
      minutes = minutes;
    }

    if (hM && dHM && sDHM && mSDHM && aMSDHM) {
      answer =
          ('$year years, $months months, $weeks weeks, $days days, $hours hours, $minutes minutes');
    } else if (hM && dHM && sDHM && mSDHM) {
      answer =
          ('$months months, $weeks weeks, $days days, $hours hours, $minutes minutes');
    } else if (hM && dHM && sDHM) {
      answer = ('$weeks weeks, $days days, $hours hours, $minutes minutes');
    } else if (hM && dHM) {
      answer = ('$days days, $hours hours, $minutes minutes');
    } else if (hM) {
      answer = ('$hours hours, $minutes minutes');
    } else {
      answer = ('$minutes minutes');
    }
    (minuteNegative < 0) ? answer = '- $answer' : answer;
    return answer;
  }

//Método para realizar el logout de la aplicacion y destruye las varibles locales
  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    log.remove('token');
  }
}
