import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBar extends StatefulWidget {

  final double width;
  final double height;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final VoidCallback onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final Function(int) searchBarOpen;
  final   FocusNode focusNode ;
  final Function(String) onChanged;
  const SearchBar({
    Key? key,

    required this.width,
    required this.searchBarOpen,
    required this.focusNode,
    required this.onChanged,
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",

    this.height = 100,

    this.color = Colors.white,

    this.textFieldColor = Colors.white,

    this.searchIconColor = Colors.black,

    this.textFieldIconColor = Colors.black,
    this.textInputAction = TextInputAction.done,

    required this.onSuffixTap,
    this.animationDurationInMilli = 375,

    required this.onSubmitted,

    this.rtl = false,

    this.autoFocus = false,

    this.style,

    this.closeSearchOnSuffixTap = false,

    this.boxShadow = true,

    this.inputFormatters,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}


int toggle = 0;


String textFieldValue = '';

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {

  late AnimationController _con;


  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,

      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),

      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: widget.height,
        width: (toggle == 0) ? 48.0 : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: toggle == 1 ? widget.textFieldColor : widget.color,
          borderRadius: BorderRadius.circular(30.0),

          boxShadow: !widget.boxShadow
              ? null
              : [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: -10.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          children: [

            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 6.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    /// can add custom color or the color will be white
                    color: widget.color,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          ///trying to execute the onSuffixTap function
                          widget.onSuffixTap();

                          // * if field empty then the user trying to close bar
                          if (textFieldValue == '') {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });

                            ///reverse == close
                            _con.reverse();
                          }

                          // * why not clear textfield here?
                          widget.textController.clear();
                          textFieldValue = '';

                          ///closeSearchOnSuffixTap will execute if it's true
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                          }
                        } catch (e) {
                          ///print the error if the try block fails
                          print(e);
                        }
                      },

                      ///suffixIcon is of type Icon
                      child: widget.suffixIcon != null
                          ? widget.suffixIcon
                          : Icon(
                        Icons.close,
                        size: 20.0,
                        color: widget.textFieldIconColor,
                      ),
                    ),
                    builder: (context, widget) {
                      ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,

              ///Using Animated opacity to change the opacity of th textField while expanding
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: widget.focusNode,
                    textInputAction: widget.textInputAction,
                    cursorRadius: Radius.circular(10.0),
                    cursorWidth: 2.0,
                    onChanged: (value) {
                      textFieldValue = value;
                      widget.onChanged(value);
                    },
                    onSubmitted: (value) => {
                      widget.onSubmitted(value),
                      unfocusKeyboard(),
                      setState(() {
                        toggle = 0;
                      }),
                      widget.textController.clear(),
                    },
                    onEditingComplete: () {
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },

                    style: widget.style != null
                        ? widget.style
                        : TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.helpText,
                      labelStyle: TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
            Material(
              /// can add custom color or the color will be white
              /// toggle button color based on toggle state
              color: toggle == 0 ? widget.color : widget.textFieldColor,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,

                ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                ///prefixIcon is of type Icon
                icon: widget.prefixIcon != null
                    ? toggle == 1
                    ? Icon(
                  Icons.arrow_back_ios,
                  color: widget.textFieldIconColor,
                )
                    : widget.prefixIcon!
                    : Icon(
                  toggle == 1 ? Icons.arrow_back_ios : Icons.search,
                  // search icon color when closed
                  color: toggle == 0
                      ? widget.searchIconColor
                      : widget.textFieldIconColor,
                  size: 20.0,
                ),
                onPressed: () {
                  setState(
                        () {
                      if (toggle == 0) {
                        toggle = 1;
                        setState(() {
                          if (widget.autoFocus)
                            FocusScope.of(context).requestFocus(widget.focusNode);
                        });

                        _con.forward();
                      } else {

                        toggle = 0;


                        setState(() {
                          if (widget.autoFocus) unfocusKeyboard();
                        });


                        _con.reverse();
                      }
                    },

                  );
                  widget.searchBarOpen(toggle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}