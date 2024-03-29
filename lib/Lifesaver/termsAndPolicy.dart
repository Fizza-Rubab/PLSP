import 'package:flutter/material.dart';
import '../appbar.dart';
import '../constants.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    double space_between = 20.0;
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: SimpleAppBar(localizations.terms_and_conditions),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(children: [
            Text(
              localizations.ls_tnc1,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc2,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc3,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc4,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc5,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc6,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc7,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc8,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc9,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.ls_tnc10,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const StadiumBorder(),
                    backgroundColor: PrimaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      localizations.back_to_register,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
