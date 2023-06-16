
import 'dart:async';
import 'package:flutter/material.dart';

class TypeWriterText extends StatefulWidget {
  const TypeWriterText(
      {Key? key,
        required this.text,
        required this.duration,
        this.alignment,
        this.maintainSize = true,
        this.repeat = false,
        this.play = true})
      : super(key: key);

  final Text text;
  final bool repeat;
  final Duration duration;
  final Alignment? alignment;
  final bool maintainSize;
  final bool? play;

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  int index = 0;

  List<String> get _textList => [
    for (int x = 0; x < widget.text.data!.characters.length; x++)
      widget.text.data!.characters.string.substring(0, x + 1)
  ];
  String _textContent = "";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (_textList.isNotEmpty && mounted) {
      //Set the first displayed [String] from [_textList].
      setState(() => _textContent = _textList.first);

      //Setting the displayed [String] from time to time.
      timer = Timer.periodic(widget.duration, (timer) {
        if (timer.tick >= _textList.length && widget.repeat == false) {
          //End the animation.
          timer.cancel();
        } else {
          //Set the rest [String] from [textList] to be displayed.
          if (widget.repeat == true) {
            setState(() {
              index = timer.tick ~/ _textList.length;
              int textIndex = timer.tick - _textList.length * index;
              _textContent = _textList[textIndex];
            });
          } else {
            setState(() {
              _textContent = _textList[timer.tick];
            });
          }
        }
      });
    }
  }

  @override
  void dispose() {
    if (timer?.isActive == true) timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.play == false) {
      return widget.text;
    } else {
      return LayoutBuilder(builder: (_, constraints) {
        TextPainter textPainter = TextPainter(
            locale: widget.text.locale,
            maxLines: widget.text.maxLines,
            strutStyle: widget.text.strutStyle,
            text: TextSpan(
                text: widget.text.data!,
                style: widget.text.style,
                locale: widget.text.locale,
                semanticsLabel: widget.text.semanticsLabel),
            textAlign: widget.text.textAlign ?? TextAlign.start,
            textDirection: widget.text.textDirection ?? TextDirection.ltr,
            textHeightBehavior: widget.text.textHeightBehavior,
            textScaleFactor: widget.text.textScaleFactor ?? 1.0,
            textWidthBasis: widget.text.textWidthBasis ?? TextWidthBasis.parent)
          ..layout(
              maxWidth: constraints.maxWidth, minWidth: constraints.minWidth);

        return Container(
            alignment: widget.alignment,
            width: widget.maintainSize == true ? textPainter.width : null,
            height: widget.maintainSize == true ? textPainter.height : null,
            child: Text(
              _textContent,
              key: widget.text.key,
              locale: widget.text.locale,
              maxLines: widget.text.maxLines,
              overflow: widget.text.overflow,
              semanticsLabel: widget.text.semanticsLabel,
              softWrap: widget.text.softWrap,
              strutStyle: widget.text.strutStyle,
              style: widget.text.style,
              textAlign: widget.text.textAlign,
              textDirection: widget.text.textDirection,
              textHeightBehavior: widget.text.textHeightBehavior,
              textScaleFactor: widget.text.textScaleFactor,
              textWidthBasis: widget.text.textWidthBasis,
            ));
      });
    }
  }
}