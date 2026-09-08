import 'package:flutter/material.dart';
import 'package:my_ecomerse/core/theme/dimensions.dart';
import 'package:my_ecomerse/core/theme/styles.dart' show poppinsMedium;

class CustomButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Function? onPressed;
  final double margin;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double? width;
  final double? height;
  final IconData? icon;
  final TextStyle? textStyle;
  final bool isLoading;

  const CustomButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.margin = 0,
    this.textColor,
    this.borderRadius = 10,
    this.backgroundColor,
    this.width,
    this.height,
    this.icon,
    this.textStyle,
    this.isLoading = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: TextButton(
        onPressed: isLoading ? null : onPressed as void Function()?,
        style: TextButton.styleFrom(
          backgroundColor:
              backgroundColor ??
              (onPressed == null
                  ? Theme.of(context).hintColor.withValues(alpha: 0.6)
                  : Theme.of(context).primaryColor),
          minimumSize: Size(width ?? 150, height ?? 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 1)
              : null,
        ),
        child: isLoading
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    ),
                     SizedBox(width: width ?? 150),

                    Text(
                     'loading',
                     style: textStyle ?? poppinsMedium.copyWith(color: textColor ?? Colors.white),
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            right: Dimensions.paddingSizeExtraSmall,
                          ),
                          child: Icon(
                            icon,
                            color: textColor ?? Theme.of(context).cardColor,
                          ),
                        )
                      : const SizedBox(),

                  Text(
                    buttonText ?? '',
                    textAlign: TextAlign.center,
                    style:
                        textStyle ??
                        poppinsMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: textColor ?? Theme.of(context).cardColor,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
