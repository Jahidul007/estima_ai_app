import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'error_text_line.dart';

class TextInputStreamField extends StatelessWidget {
  final Stream<String> stream;
  final Stream<String?>? errorStream;
  final String label;
  final String hint;
  final int maxLine;
  final Function(String name) onChange;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final String? prefixText;
  final bool? readOnly;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? suffixWidget;

  const TextInputStreamField(
      {Key? key,
      required this.stream,
      this.errorStream,
      required this.label,
      required this.hint,
      required this.onChange,
      this.textInputType = TextInputType.text,
      required this.textEditingController,
      this.prefixText,
      this.textInputFormatter,
      this.readOnly,
        this.maxLine =1 ,
      this.suffixWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          textEditingController.value =
              textEditingController.value.copyWith(text: snapshot.data);
        }
        return CustomInputWithError(
          inputWidget: TextFormField(
            controller: textEditingController,
            onChanged: (name) => onChange(name),
            keyboardType: textInputType,
            readOnly: readOnly ?? false,
            textInputAction: TextInputAction.next,
            inputFormatters: textInputFormatter ??
                [
                  FilteringTextInputFormatter(
                    RegExp("[A-Za-z0-9#+-_. ()[]]*"),
                    allow: true,
                  ),
                  //LengthLimitingTextInputFormatter(100),
                ],
            maxLines: maxLine,
            decoration: InputDecoration(
                prefixText: prefixText == null || prefixText!.trim().isEmpty
                    ? ""
                    : "$prefixText ",
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                labelText: label,
                labelStyle: labelText,
                hintText: hint,
                suffixIcon: suffixWidget
                // errorText: snapshot.error,
                ),
          ),
          errorStream: errorStream!,
        );
      },
    );
  }
}
