import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../main.dart';

class Lab01 extends StatefulWidget {
  @override
  Lab01State createState() {
    return Lab01State();
  }
}

FirebaseAnalytics analytics = FirebaseAnalytics();

enum SingingCharacter { radio1, radio2 }

class Lab01State extends State<Lab01> {
  final _formKey = GlobalKey<FormState>();

  SfRangeValues _values = SfRangeValues(40.0, 80.0);
  double _value = 40.0;

  SingingCharacter? _character = SingingCharacter.radio1;

  bool rememberMe = false;

  final checkedValue = 0;

  int data = 0;

  @override
  Widget build(BuildContext context) {
    MyApp.analytics
        .logEvent(name: 'Flutter_labs_lab1_tab_was_opened', parameters: null);
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text('Введите ваши данные:',
                    style: TextStyle(fontSize: 18)),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Введите электронную почту",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Электронная поста не введена';
                  }
                  return null;
                },
              ),
              Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Введите пароль",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Пароль не введен';
                        }
                        return null;
                      },
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: Center(
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        }
                      ),
                      const Text('Запомнить пароль?',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Text('Сколько вам лет?', style: TextStyle(fontSize: 18)),
              ),
              SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(
                        trackColor: Colors.blueGrey,
                        progressBarColor: Colors.blue,
                        hideShadow: true),
                    infoProperties: InfoProperties(
                        bottomLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        bottomLabelText: 'Лет',
                        mainLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600),
                        modifier: (double value) {
                          final temp = value.toInt();
                          return '$temp';
                        }),
                  ),
                  onChange: (double value) {
                    print(value.ceil().toInt().toString());
                    setState(() {
                      data = value.ceil().toInt();
                    });
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text('Выбранное значение: $data', style: const TextStyle(fontSize: 18)),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text('Кто вы?', style: TextStyle(fontSize: 18)),
              ),
              Row(textDirection: TextDirection.ltr, children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Человек'),
                    leading: Radio<SingingCharacter>(
                      activeColor: Colors.blue,
                      value: SingingCharacter.radio1,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Робот'),
                    leading: Radio<SingingCharacter>(
                      activeColor: Colors.blue,
                      value: SingingCharacter.radio2,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
              ]),
              Row(textDirection: TextDirection.ltr, children: [
                Expanded(child: 
                Padding(
                  padding: EdgeInsets.only(right: 10), 
                  child: ElevatedButton(
                  onPressed: () {},
                  onLongPress: () {
                    MyApp.analytics.logEvent(
                        name: 'flutter_labs_lab1_longPressButton_pressed', parameters: null);
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Вы правильно нажали на кнопку!')));
                    }
                  },
                  child: const Text('Долгое нажатие'),
                ),
                ),
                ),
                Expanded(child: 
                Padding(
                  padding: EdgeInsets.only(left: 10), 
                  child: ElevatedButton(
                  onPressed: () {
                    MyApp.analytics.logEvent(
                        name: 'flutter_labs_lab1_shortPressButton_pressed', parameters: null);
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Вы правильно нажали на кнопку!')));
                    }
                  },
                  child: const Text('Короткое нажатие'),
                ),
                ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}