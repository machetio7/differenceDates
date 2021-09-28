import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  String dateOne = '', dateTwo = '', aswer = '';
  DateTime dateInputOne = DateTime.now();
  DateTime dateInputTwo = DateTime.now();
  TimeOfDay timeOne = TimeOfDay.now();
  TimeOfDay timeTwo = TimeOfDay.now();
  int minuteNegative = 0;

  String _formatter(DateTime date) {
    DateFormat format = DateFormat('dd-MM-yyyy H:mm a');
    return format.format(date);
  }

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
        // ignore: avoid_print
        print('antes de Update one');
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

    minutos = (date2.difference(date1).inMinutes).toString();
    minuteNegative = int.parse(minutos);
    print(minutos);
    if (int.parse(minutos) >= 60) {
      horas = (double.parse(minutos) / 60).toStringAsFixed(2);
      data = horas.split('.');
      minutos = data[1]; //00
      if (int.parse(data[0]) >= 24) {
        dias = (double.parse(data[0]) / 24).toStringAsFixed(2);
        data = dias.split('.');
        data[1] = '0.' + data[1];
        horas = (double.parse(data[1]) * 24).floor().toString();
        if (int.parse(data[0]) >= 7) {
          semanas = (double.parse(data[0]) / 7).toStringAsFixed(2);
          data = semanas.split('.');
          data[1] = '0.${data[1]}';
          dias = (double.parse(data[1]) * 7).floor().toString(); //00
          if (int.parse(data[0]) > 4.4) {
            meses = (double.parse(data[0]) / 4.4).toStringAsFixed(2);
            data = meses.split('.');
            data[1] = '0.${data[1]}';
            semanas = (double.parse(data[1]) * 4.4).floor().toString();
            if (int.parse(data[0]) >= 12) {
              anos = (double.parse(data[0]) / 12).toStringAsFixed(2);
              data = anos.split('.');
              data[1] = '0.${data[1]}';
              anos = data[0];
              meses = (double.parse(data[1]) * 12).round().toString();
            } else {
              meses = data[0].toString();
            }
          } else {
            semanas = data[0].toString();
          }
        } else {
          dias = data[0].toString();
        }
      } else {
        horas = data[0].toString();
      }
    } else {
      minutos = minutos;
    }

    if (int.parse(anos) > 0 && int.parse(meses) >= 0) {
      if (meses == '0') {
        if (anos == '1') {
          return ('$anos año');
        } else {
          return ('$anos años');
        }
      } else {
        return ('$anos Años, $meses meses');
      }
    } else if (int.parse(meses) > 0 && int.parse(semanas) >= 0) {
      if (semanas == '0') {
        if (meses == '1') {
          return ('$meses mes');
        } else {
          return ('$meses meses');
        }
      } else {
        return ('$meses meses, $semanas semanas');
      }
    } else if (int.parse(semanas) > 0 && int.parse(dias) >= 0) {
      if (dias == '0') {
        if (semanas == '1') {
          return ('$semanas semana');
        } else {
          return ('$semanas semanas');
        }
      } else {
        return ('$semanas semanas, $dias dias');
      }
    } else if (int.parse(dias) > 0 && int.parse(horas) >= 0) {
      if (horas == '0') {
        if (dias == '1') {
          return ('$dias dia');
        } else {
          return ('$dias dias');
        }
      } else {
        return ('$dias dias, $horas horas');
      }
    } else if (int.parse(horas) > 0 && int.parse(minutos) >= 0) {
      if (minutos == '0') {
        if (horas == '1') {
          return ('$horas hora');
        } else {
          return ('$horas horas');
        }
      } else {
        return ('$horas horas, $minutos minutos');
      }
    } else {
      return ('$minutos minutos');
    }
  }
}
