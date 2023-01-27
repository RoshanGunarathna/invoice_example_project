import 'package:flutter/material.dart';
import 'package:invoice/features/invoice/screens/invoice_screen.dart';

import '../../../common/utils/show_snackbar.dart';
import '../../../common/widget/custom_button.dart';
import '../../../models/ceiling_model.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int roomWidth;
  late int roomLength;
  int area = 0;
  int number_of_boards = 0;
  int main_tee = 0;
  int cross_tee = 0;
  double req_wall_angles = 0;
  bool onChange = false;

  //controller
  final _roomwidthController = TextEditingController();
  final _roomLengthController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _roomLengthController.dispose();
    _roomwidthController.dispose();
  }

  void _calculations() {
    if (_roomLengthController.text.isNotEmpty &&
        _roomwidthController.text.isNotEmpty) {
      setState(() {
        roomLength = int.parse(_roomLengthController.text);
        roomWidth = int.parse(_roomwidthController.text);
        area = roomWidth * roomLength;
        number_of_boards = (area / 4).round();
        req_wall_angles = ((roomWidth * 2) + (roomLength * 2)) / 10.round();
        main_tee = ((roomLength / 12) * (roomWidth / 2) - 1).round();
        cross_tee = ((roomWidth / 2) * (roomLength / 2) - 1).round();
      });
    }
  }

  void _submit() {
    if (_roomLengthController.text.isNotEmpty &&
        _roomwidthController.text.isNotEmpty) {
      if (onChange) {
        setState(() {
          roomLength = int.parse(_roomLengthController.text);
          roomWidth = int.parse(_roomwidthController.text);
          area = roomWidth * roomLength;
          number_of_boards = (area / 4).round();
          req_wall_angles = ((roomWidth * 2) + (roomLength * 2)) / 10.round();
          main_tee = ((roomLength / 12) * (roomWidth / 2) - 1).round();
          cross_tee = ((roomWidth / 2) * (roomLength / 2) - 1).round();
        });
      }

      Navigator.pushNamed(context, InvoiceScreen.routeName, arguments: [
        CeilingModel(
          item: 'MAIN TEE',
          size: 12,
          price: 100,
          quantity: main_tee,
        ),
        CeilingModel(
          item: 'CROSS TEE',
          size: 2,
          price: 150,
          quantity: cross_tee,
        ),
        CeilingModel(
          item: 'WALL ANGLE',
          size: 10,
          price: 400,
          quantity: req_wall_angles.toInt(),
        ),
      ]);
    } else {
      showSnackBar(context: context, text: 'Fill all the field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('Ceiling Nation Estimator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _roomwidthController,
                decoration: const InputDecoration(labelText: 'Room Width'),
                onSubmitted: (value) => roomWidth = int.parse(value),
                onChanged: (value) => _calculations(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _roomLengthController,
                decoration: const InputDecoration(labelText: 'Room Length'),
                onSubmitted: (value) => roomLength = int.parse(value),
                onChanged: (value) => _calculations(),
              ),
            ),
            CustomButton(onPressed: _submit, text: 'Submit'),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Area :"),
                ),
                Text(area.toString()),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("No of Ceiling Boards :"),
                ),
                Text(number_of_boards.toString()),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Req Wall Angles :"),
                ),
                Text(req_wall_angles.toString()),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Req Main tee :"),
                ),
                Text(main_tee.toString()),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(" Req cross tee:"),
                ),
                Text(cross_tee.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
