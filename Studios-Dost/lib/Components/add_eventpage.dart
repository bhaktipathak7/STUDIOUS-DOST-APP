import 'package:StudiosDost/Components/event.dart';
import 'package:StudiosDost/Components/event_provider.dart';
import 'package:StudiosDost/Components/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  final Event? event;
  const AddEvent({Key? key, this.event}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  late DateTime from, to;

  @override
  void initState() {
    if (widget.event == null) {
      from = DateTime.now();
      to = DateTime.now().add(const Duration(hours: 2));
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const CloseButton(),
          title: const Text("Add Task"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: saveFrom,
            )
          ]),
      body: Container(
        margin:const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(
                height: 20,
              ),
              buildDates()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        style: const TextStyle(fontSize: 24),
        validator: (title) =>
            title != null && title.isEmpty ? "Title Cannot be Empty" : null,
        onFieldSubmitted: (_) => saveFrom,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), hintText: "Add Title"),
        controller: titleController,
      );

  Widget buildDates() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );
  Widget buildFrom() => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                  text: Utils.toDate(from),
                  onClicked: () => pickFromDateTime(pickDate: true)),
            ),
            Expanded(
              child: buildDropdownField(
                  text: Utils.toTime(from),
                  onClicked: () => pickFromDateTime(pickDate: false)),
            )
          ],
        ),
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(from, pickDate: pickDate);
    if (date == null) {
      return;
    }
    if (date.isAfter(to)) {
      to = DateTime(date.year, date.month, date.day, to.hour, to.minute);
    }
    setState(() => from = date);
  }

  Future pickToDatetime({required bool pickDate}) async {
    final date = await pickDateTime(to,
        firstDate: pickDate ? from : null, pickDate: pickDate);
    if (date == null) {
      return;
    }
    if (date.isAfter(to)) {
      to = DateTime(date.year, date.month, date.day, to.hour, to.minute);
    }
    setState(() => to = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));

      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) {
        return null;
      }
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget buildTo() => buildHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                  text: Utils.toDate(to),
                  onClicked: () => pickToDatetime(pickDate: true)),
            ),
            Expanded(
              child: buildDropdownField(
                  text: Utils.toTime(to),
                  onClicked: () => pickToDatetime(pickDate: false)),
            )
          ],
        ),
      );

  Widget buildDropdownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child
        ],
      );
  Future saveFrom() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event =
          Event(titleController.text, "Description", from, to, isAllDay: false);
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);
      Navigator.of(context).pop();
    }
  }
}
