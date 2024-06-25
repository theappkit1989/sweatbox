
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/size_config.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';




class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var maxLine = 1;
  var minLine = 1;
  Function? validator;
  VoidCallback? onChange;
  TextEditingController? mController;
  TextInputType? keyboardType;
  VoidCallback? onPressed;
  var hintText;
  var labelText;
  Function? onSubmitted;
  TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatter;
  FocusNode? focusNode;
  String? type;
  TextAlign? textAlign;
  String? labelInfo;
  String? icon;
  bool? localIcon = false;
  Color? hintColor; Color? labelColor;
  IconData? staticIcon;
  double? verticalPadding;
  double? horizontalPadding;
  double? radius;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  Widget? suffix;
  Widget? prefix;
  int? maxLength;
  OutlineInputBorder? focusedBorder;
  OutlineInputBorder? enabledBorder;

  EditText(
      {
      var this.isPassword = true,
      var this.isSecure = false,this.labelColor,
      var this.mController,
      var this.maxLine = 1,
      var this.minLine = 1,this.radius,
      this.validator,this.maxLength,
      this.keyboardType,
      this.hintText,this.hintColor,this.prefix,this.suffix,
      this.labelText,
      this.textInputAction,
      this.inputFormatter,
      this.focusNode,
      this.type,
      this.onSubmitted,this.verticalPadding,this.horizontalPadding,
      this.textAlign = TextAlign.start,
      this.labelInfo,
      this.icon,
      this.localIcon,this.textStyle,this.hintStyle,this.labelStyle,this.onChange,
      this.staticIcon,this.focusedBorder,this.enabledBorder});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
      return TextFormField(
        style: widget.textStyle,
        obscureText: widget.isPassword,
        controller: widget.mController,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatter,
        focusNode: widget.focusNode,cursorColor: ColorLight.black,
        textAlign: widget.textAlign!,
        minLines: widget.minLine, maxLength: widget.maxLength ?? null ,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.hintText,contentPadding: EdgeInsets.only(top:
        widget.verticalPadding!,left: widget.horizontalPadding!),
          alignLabelWithHint: false,counterText: '',
          isDense: false,labelText: widget.labelText,
          labelStyle:  widget.labelStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: widget.hintStyle,
          border: widget.enabledBorder ?? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius?? 24.0),
            borderSide: BorderSide(
                color: ColorLight.progressBgColor,
                width: 1.1),
          ),
         enabledBorder: widget.enabledBorder ?? OutlineInputBorder(
           borderSide: BorderSide(color: ColorLight.progressBgColor,width: 1.1),
           borderRadius: BorderRadius.circular(widget.radius?? 24.0),
          ),
          focusedBorder: widget.focusedBorder ?? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius?? 24.0),
            borderSide: BorderSide(
                color: ColorLight.focusedTextColor,
                width: 1.1),
        ), errorBorder:OutlineInputBorder(
          borderSide: BorderSide(color: ColorLight.redBgColor,width: 1.1),
          borderRadius: BorderRadius.circular(widget.radius?? 24.0),
        ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorLight.redBgColor,width: 1.1),
            borderRadius: BorderRadius.circular(widget.radius?? 24.0),
          ),
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffix,
        ),
        validator: widget.validator!=null ?(value) =>  widget.validator!(value) :null,
        onChanged: widget.onChange!=null ?(value) => widget.onChange!() : null,
      );

  }

  @override
  State<StatefulWidget>? createState() {
    return null;
  }
}


class TextClass extends StatefulWidget {
  var textContent;
  FontWeight? fontWeight;
  double? fontSize;
  Color? textcolor;
  String? coming;
  FontStyle? style;
  TextDecoration? decoration;
  TextAlign? textAlign = TextAlign.center;

  TextClass(
      {@required this.textContent,
      this.fontWeight,
      this.fontSize,
      this.textcolor,
      this.coming,this.style,this.decoration,
      this.textAlign = TextAlign.center});

  @override
  State<StatefulWidget> createState() {
    return TextBoxState();
  }
}

class TextBoxState extends State<TextClass> {
  @override
  Widget build(BuildContext context) {

    return RichText(
      text: TextSpan(text : widget.textContent,style:widget.coming != null
          ? TextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,decoration:widget.decoration!=null?widget.decoration:null ,
            color:
            widget.textcolor != null ? widget.textcolor : colorDarkGrey,fontStyle: widget.style!=null?widget.style:FontStyle.normal
          )
          :  TextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,decoration:widget.decoration!=null?widget.decoration:null ,
            color:
            widget.textcolor != null ? widget.textcolor : colorDarkGrey,fontStyle: widget.style!=null?widget.style:FontStyle.normal
          )),
      textAlign: widget.textAlign!,
    );

  }
}

class TextClassItalics extends StatefulWidget {
  var textContent;
  FontWeight? fontWeight;
  double? fontSize;
  Color? textcolor;
  String? coming;
  TextAlign? textAlign = TextAlign.center;

  TextClassItalics(
      {@required this.textContent,
      this.fontWeight,
      this.fontSize,
      this.textcolor,
      this.coming,
      this.textAlign = TextAlign.center});

  @override
  State<StatefulWidget> createState() {
    return TextClassItalicsState();
  }
}

class TextClassItalicsState extends State<TextClassItalics> {
  @override
  Widget build(BuildContext context) {
    return RichText(
     text: TextSpan(text : widget.textContent,style:widget.coming != null
         ?  TextStyle(
             fontSize: widget.fontSize,
             fontWeight: widget.fontWeight,
             color: widget.textcolor != null
                 ? widget.textcolor
                 : colorDarkGrey,
             fontStyle: FontStyle.italic)
         : TextStyle(
             fontSize: widget.fontSize,
             fontWeight: widget.fontWeight,
             color: widget.textcolor != null
                 ? widget.textcolor
                 : colorDarkGrey,
             fontStyle: FontStyle.italic) ),
      textAlign: widget.textAlign!,
    );
  }
}

class Button extends StatefulWidget {
  var textContent;
  VoidCallback? onPressed;
  double? fontSize;
  double? radius;
  double? width;
  double? height;
  Color? buttontextColor;
  Color? buttonBg;
  FontWeight? weight;
  double? margin;


  Button(
      {@required this.textContent,
      @required this.onPressed,this.radius,this.width,this.buttonBg,this.buttontextColor,this.height,this.weight,this.margin,
      this.fontSize = textSizeLargeMedium});

  @override
  State<StatefulWidget> createState() {
    return ButtonState();
  }
}

class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,style:ElevatedButton.styleFrom(
      backgroundColor: widget.buttonBg,
      padding: EdgeInsets.zero,maximumSize: Size(widget.width??Get.width, widget.height ?? Get.height*0.06)
      // Background color
      ),
      child: Container(
        width:Get.width,alignment: Alignment.center,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.buttonBg,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius!)),
        ),
        child: texts(widget.textContent,
            textColor: colorWhite,
            fontSize: widget.fontSize,
            fontFamily: montFontFamily,
            fontWeight: widget.weight ?? FontWeight.w500),
      ),
    );
  }

  @override
  State<StatefulWidget>? createState() {
    // TODO: implement createState
    return null;
  }
}

class SmallButton extends StatefulWidget {
  var textContent;
  VoidCallback? onPressed;
  double? fontSize = textSizeLargeMedium;
  double? width = SizeConfig.blockSizeHorizontal * 24;
  Color? bgColor;

  SmallButton(
      {@required this.textContent,
      @required this.onPressed,
      this.fontSize = textSizeLargeMedium,
      this.width});

  @override
  State<StatefulWidget> createState() {
    return SmallButtonState();
  }
}

class SmallButtonState extends State<SmallButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width,
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical*1.25),
        decoration: const BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Center(
          child: texts(widget.textContent,
              textColor: colorWhite,
              fontSize: widget.fontSize,isCentered: true,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget>? createState() {
    // TODO: implement createState
    return null;
  }
}

class T10TopBar extends StatefulWidget {
  var titleName;

  T10TopBar(var this.titleName);

  @override
  State<StatefulWidget> createState() {
    return T10TopBarState();
  }
}

class T10TopBarState extends State<T10TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffffffff),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
            ),
            Center(
              child: texts(
                widget.titleName,
                fontFamily: fontBold,
                textColor: Colors.black,
                fontSize: textSizeLargeMedium,
              ),
            ),
            // SvgPicture.asset("assets/searchIcon.svg", color: Colors.black)
            //     .paddingOnly(right: 16),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget>? createState() {
    return null;
  }
}

Widget texts(String text,
    {var fontSize = textSizeLargeMedium,
    textColor = color_text_secondary,String? childText,Color? childTextColor,
    var fontFamily,
    var isCentered = false,
    var maxLine,
    var latterSpacing = 0.0,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
    bool isMandatory = false,
    FontWeight? fontWeight}) {
  return
    RichText(
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      text: TextSpan(
        text: text,
        style:TextStyle(
              fontFamily: fontFamily ,
              fontSize: fontSize,
              color: textColor,
              height: 1.3,
              fontWeight: fontWeight,
              letterSpacing: latterSpacing,
            ),
        children: <TextSpan>[
          TextSpan(text: childText ?? "", style:  TextStyle(
              fontFamily: fontFamily ,
              fontSize: fontSize,
              color: childTextColor,
              height: 1.5,
              fontWeight: fontWeight,
              letterSpacing: latterSpacing,
            ),
          )
        ],
      ),
    );
}

final headingStyle = TextStyle(
  fontSize: SizeConfig.blockSizeHorizontal * 10,
  fontWeight: FontWeight.bold,
  color: colorDarkGrey,
  height: 1.5,
);

class LabelEditText extends StatefulWidget {
  Widget? text;
  double? bottom;
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var maxLine = 1;
  var minLine = 1;
  Function? validator;
  TextEditingController? mController;
  TextInputType? keyboardType;
  VoidCallback? onPressed;
  var hintText;
  var labelText;
  Function? onSubmitted;
  TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatter;
  FocusNode? focusNode;
  String? type;
  double? vertical, horizontal;
  TextAlign? textAlign;

  LabelEditText(this.text, this.bottom,
      {var this.fontSize = textSizeMedium,
      var this.textColor = color_text_secondary,
      var this.fontFamily = fontRegular,
      var this.isPassword = false,
      var this.isSecure = false,
      var this.mController,
      var this.maxLine = 1,
      var this.minLine = 1,
      this.validator,
      this.keyboardType,
      this.hintText,
      this.labelText,
      this.textInputAction,
      this.inputFormatter,
      this.focusNode,
      this.type,
      this.vertical,
      this.horizontal,
      this.onSubmitted,
      this.textAlign = TextAlign.start});

  @override
  _LabelEditTextState createState() => _LabelEditTextState();
}

class _LabelEditTextState extends State<LabelEditText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: SizeConfig.blockSizeHorizontal * 96,
            margin: EdgeInsets.only(bottom: widget.bottom!),
            child: widget.text),
        TextFormField(
          style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
          obscureText: widget.isPassword,
          controller: widget.mController,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatter,
          focusNode: widget.focusNode,
          textAlign: widget.textAlign!,
          minLines: widget.minLine,
          maxLines: widget.maxLine,
          onFieldSubmitted: (value)
          {
            widget.onSubmitted!();
          },
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: widget.hintText,
            isDense: false,
            hintStyle: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 1.95,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                  width: 1.2, style: BorderStyle.none, color: colorBorderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                  width: 1.25,
                  style: BorderStyle.solid,
                  color: colorBorderGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                  width: 1.25, style: BorderStyle.solid, color: colorPrimary),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 1.25,
                horizontal: SizeConfig.blockSizeHorizontal * 4),
          ),
          validator: (value)
          {
            widget.validator;
          },
        ),
      ],
    );
  }
}
