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

//Método para recolectar las 2 fechas y horas establecidas por el usuario en UI
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
    String anos = '0';
    String dias = '0';
    String semanas = '0';
    String meses = '0';
    String horas = '0';
    String minutos = '0';
    List<String> data = [];
    String answer = '';

//Validaciones para mostrar la diferencia
    bool hM = false, dHM = false, sDHM = false, mSDHM = false, aMSDHM = false;

    minutos = (date2.difference(date1).inMinutes).toString();
    minuteNegative = date2.difference(date1).inMinutes;

    if ((int.parse(minutos).abs()) >= 60) {
      horas = (double.parse(minutos).abs() / 60).toString();
      data = horas.split('.');
      minutos = data[1]; //00
      data[1] = '0.' + data[1];
      minutos = (double.parse(data[1]) * 60).round().toString();
      if (int.parse(data[0]) >= 24) {
        hM = true;
        dias = (double.parse(data[0]) / 24).toString();
        data = dias.split('.');
        data[1] = '0.' + data[1];
        horas = (double.parse(data[1]) * 24).round().toString();
        if (int.parse(data[0]) >= 7) {
          dHM = true;
          semanas = (double.parse(data[0]) / 7).toString();
          data = semanas.split('.');
          data[1] = '0.${data[1]}';
          dias = (double.parse(data[1]) * 7).round().toString(); //00
          if (int.parse(data[0]) > 4.3) {
            sDHM = true;
            meses = (double.parse(data[0]) / 4.3).toString();
            data = meses.split('.');
            data[1] = '0.${data[1]}';
            semanas = (double.parse(data[1]) * 4.3).round().toString();
            if (int.parse(data[0]) >= 12) {
              mSDHM = true;
              anos = (double.parse(data[0]) / 12).toString();
              data = anos.split('.');
              data[1] = '0.${data[1]}';
              anos = data[0];
              meses = (double.parse(data[1]) * 12).round().toString();
              aMSDHM = true;
            } else {
              meses = data[0].toString();
              mSDHM = true;
            }
          } else {
            semanas = data[0].toString();
            sDHM = true;
          }
        } else {
          dias = data[0].toString();
          dHM = true;
        }
      } else {
        horas = data[0].toString();
        hM = true;
      }
    } else {
      minutos = minutos;
    }

    if (hM && dHM && sDHM && mSDHM && aMSDHM) {
      answer =
          ('$anos años,$meses meses, $semanas semanas, $dias dias, $horas horas, $minutos minutos');
    } else if (hM && dHM && sDHM && mSDHM) {
      answer =
          ('$meses meses, $semanas semanas, $dias dias, $horas horas, $minutos minutos');
    } else if (hM && dHM && sDHM) {
      answer = ('$semanas semanas, $dias dias, $horas horas, $minutos minutos');
    } else if (hM && dHM) {
      answer = ('$dias dias, $horas horas, $minutos minutos');
    } else if (hM) {
      answer = ('$horas horas, $minutos minutos');
    } else {
      answer = ('$minutos minutos');
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
