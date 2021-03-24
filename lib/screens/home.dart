import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soilnutrientanalyzer/bloc/crop_dropdown_bloc.dart';
import 'package:soilnutrientanalyzer/bloc/result_bloc.dart';
import 'package:soilnutrientanalyzer/metadata/meta_text.dart';
import 'package:soilnutrientanalyzer/model/crop.dart';
import 'package:soilnutrientanalyzer/screens/results_screen.dart';

// import 'dart:typed_data';
// import 'dart:async';
// import 'package:usb_serial/usb_serial.dart';
// import 'package:usb_serial/transaction.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> languages = [
    "English",
    "தமிழ்",
    "हिन्दी",
  ];

  String selectedLanguage = "English";

  @override
  void initState() {
    BlocProvider.of<LanguageCubit>(context).updateLanguage('ta', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = context.watch<LanguageCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(MetaText.soilNutrientAnalyzer),
        centerTitle: true,
        backgroundColor: Color(0xFF799054),
        elevation: 0,
      ),
      body: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (BuildContext context, LanguageState state) {
        if (state is LanguageLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LanguageSuccessState) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF799054),
                  Color(0xFF52A178),
                  Color(0xFFACB3A3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.6, 1],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                CustomDropdown(
                  title: MetaText.selectLanguage,
                  items: languages,
                  value: selectedLanguage,
                  onChanged: (String val) async {
                    switch (val) {
                      case "English":
                        languageCubit.updateLanguage('en', state);
                        break;
                      case "தமிழ்":
                        languageCubit.updateLanguage('ta', state);
                        break;
                      case "हिन्दी":
                        languageCubit.updateLanguage('hi', state);
                        break;
                    }
                    setState(() {
                      selectedLanguage = val;
                    });
                  },
                ),
                CustomDropdown(
                  title: MetaText.SelectTypeOfSoil,
                  items: state.soils,
                  value: state.selectedSoil,
                  onChanged: (String val) {
                    languageCubit.updateSoil(state, val);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          MetaText.SelectCrop,
                          style: TextStyle(color: Colors.white),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          items: state.crops
                              .map((Crop e) => DropdownMenuItem(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.asset(
                                            e.image,
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(e.name),
                                        ),
                                      ],
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          selectedItemBuilder: (BuildContext context) {
                            return state.crops
                                .map((Crop e) => Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.asset(
                                            e.image,
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            e.name,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList();
                          },
                          value: state.selectedCrop,
                          onChanged: (Crop val) {
                            languageCubit.updateCrop(state, val);
                          },
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
                Builder(
                  builder: (BuildContext context) => FlatButton(
                    child: Text(
                      MetaText.Calculate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    color: Color(0xFF52A178),
                    onPressed: () {
                      BlocProvider.of<ResultCubit>(context).getResult(
                        state.selectedCrop,
                        state.basicWords['Temperature'],
                        state.basicWords['Moisture'],
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ResultsScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Spacer(flex: 3),
              ],
            ),
          );
        } else if (state is LanguageErrorState) {
          return Center(child: Text(state.error));
        } else {
          return Container();
        }
      }),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key key,
    @required this.title,
    @required this.items,
    this.value,
    this.onChanged,
  }) : super(key: key);
  final String title;
  final List<String> items;
  final String value;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(color: Colors.white)),
            flex: 2,
          ),
          Expanded(
            child: DropdownButton(
              isExpanded: true,
              items: items
                  .map((String e) => DropdownMenuItem(
                        child: Text(e, style: TextStyle(color: Colors.black)),
                        value: e,
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) {
                return items
                    .map((String e) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(e, style: TextStyle(color: Colors.white))))
                    .toList();
              },
              value: value,
              onChanged: onChanged,
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}

// Center(
        //   child: Column(
        //     children: <Widget>[
        //       Text(
        //         _ports.length > 0
        //             ? "Available Serial Ports"
        //             : "No serial devices available",
        //         style: Theme.of(context).textTheme.title,
        //       ),
        //       ..._ports,
        //       Text('Status: $_status\n'),
        //       ListTile(
        //         title: TextField(
        //           controller: _textController,
        //           decoration: InputDecoration(
        //             border: OutlineInputBorder(),
        //             labelText: 'Text To Send',
        //           ),
        //         ),
        //         trailing: RaisedButton(
        //           child: Text("Send"),
        //           onPressed: _port == null
        //               ? null
        //               : () async {
        //                   if (_port == null) {
        //                     return;
        //                   }
        //                   String data = _textController.text + "\r\n";
        //                   await _port.write(Uint8List.fromList(data.codeUnits));
        //                   _textController.text = "";
        //                 },
        //         ),
        //       ),
        //       Text("Result Data", style: Theme.of(context).textTheme.title),
        //       ..._serialData,
        //     ],
        //   ),
        // ),
      

      // UsbPort _port;
  // String _status = "Idle";
  // List<Widget> _ports = [];
  // DataModel _serialData;
  // StreamSubscription<String> _subscription;
  // Transaction<String> _transaction;
  // int _deviceId;
  // TextEditingController _textController = TextEditingController();

  // Future<bool> _connectTo(device) async {
  //   _serialData = null;

  //   if (_subscription != null) {
  //     _subscription.cancel();
  //     _subscription = null;
  //   }

  //   if (_transaction != null) {
  //     _transaction.dispose();
  //     _transaction = null;
  //   }

  //   if (_port != null) {
  //     _port.close();
  //     _port = null;
  //   }

  //   if (device == null) {
  //     _deviceId = null;
  //     setState(() {
  //       _status = "Disconnected";
  //     });
  //     return true;
  //   }

  //   _port = await device.create();
  //   if (!await _port.open()) {
  //     setState(() {
  //       _status = "Failed to open port";
  //     });
  //     return false;
  //   }

  //   _deviceId = device.deviceId;
  //   await _port.setDTR(true);
  //   await _port.setRTS(true);
  //   await _port.setPortParameters(
  //       115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

  //   _transaction = Transaction.stringTerminated(
  //       _port.inputStream, Uint8List.fromList([13, 10]));

  //   _subscription = _transaction.stream.listen((String line) {
  //     setState(() {
  //       _serialData = DataModel.fromJson(line);
  //     });
  //   });

  //   setState(() {
  //     _status = "Connected";
  //   });
  //   return true;
  // }

  // void _getPorts() async {
  //   _ports = [];
  //   List<UsbDevice> devices = await UsbSerial.listDevices();
  //   print(devices);

  //   devices.forEach((device) {
  //     _ports.add(
  //       ListTile(
  //         leading: Icon(Icons.usb),
  //         title: Text(device.productName),
  //         subtitle: Text(device.manufacturerName),
  //         trailing: RaisedButton(
  //           child:
  //               Text(_deviceId == device.deviceId ? "Disconnect" : "Connect"),
  //           onPressed: () {
  //             _connectTo(_deviceId == device.deviceId ? null : device)
  //                 .then((res) {
  //               _getPorts();
  //             });
  //           },
  //         ),
  //       ),
  //     );
  //   });

  //   setState(() {
  //     print(_ports);
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   UsbSerial.usbEventStream.listen((UsbEvent event) {
  //     _getPorts();
  //   });
  //   _getPorts();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _connectTo(null);
  // }

