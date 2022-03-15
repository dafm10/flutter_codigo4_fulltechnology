import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/category_model.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/textfield_normal_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertFormWidget extends StatefulWidget {
  final String title;
  final bool type;
  final GeneralModel? generalModel;
  final String collection;

  AlertFormWidget({
    required this.title,
    required this.type,
    this.generalModel,
    required this.collection,
  });

  @override
  State<AlertFormWidget> createState() => _AlertFormWidgetState();
}

class _AlertFormWidgetState extends State<AlertFormWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool status = true;

  late final FirebaseService _myFirebaseService =
      FirebaseService(collection: widget.collection);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.categoryModel);
    if (widget.generalModel != null) {
      _descriptionController.text = widget.generalModel!.description;
      status = widget.generalModel!.status;
    }
  }

  saveRegister() {
    if (_formKey.currentState!.validate()) {
      if (widget.type) {
        // Agregar un nuevo registro
        GeneralModel category = GeneralModel(
          description: _descriptionController.text,
          status: status,
        );
        _myFirebaseService.addGeneral(category).then((value) {
          if (value.isNotEmpty) {
            Navigator.pop(context);
            messageSuccessSnackBar(context, 2);
          }
        });
      } else {
        // modifica
        widget.generalModel!.description = _descriptionController.text;
        widget.generalModel!.status = status;
        _myFirebaseService.updateGeneral(widget.generalModel!).then((value) {
          Navigator.pop(context);
          messageSuccessSnackBar(context, 1);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
      height: 370,
      decoration: const BoxDecoration(
        color: Color(0xfff8f8f8),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: COLOR_BRAND_PRIMARY,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              height: 4,
              width: 100,
              decoration: BoxDecoration(
                color: COLOR_BRAND_PRIMARY,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFieldNormalWidget(
              controller: _descriptionController,
              hintText: "Descripción",
              icon: 'align-left',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                const Text(
                  "Estado: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Checkbox(
                  activeColor: COLOR_BRAND_PRIMARY,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  value: status,
                  onChanged: (bool? value) {
                    status = value!;
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Container(
              width: double.infinity,
              height: 52.0,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                color: COLOR_BRAND_PRIMARY,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/save.svg',
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text(
                      "Guardar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  saveRegister();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
