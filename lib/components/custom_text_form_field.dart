import "package:flutter/material.dart";
import "package:lfti_app/classes/Constants.dart";
import "package:lfti_app/components/custom_card.dart";

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    @required TextEditingController textController,
    @required String label,
  })  : _textController = textController,
        _label = label,
        super(key: key);

  final TextEditingController _textController;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: kCardBackground.withOpacity(0.5),
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_label, style: kLabelTextStyle),
          TextFormField(
            autofocus: false,
            minLines: 1,
            maxLines: 3,
            controller: _textController,
            style: kSmallBoldTextStyle.copyWith(fontStyle: FontStyle.italic),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 18.0,
                ),
                onPressed: () {
                  _textController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
