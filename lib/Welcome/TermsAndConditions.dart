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
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(children: [
            Text(
              localizations.tnc1,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc2,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc3,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc4,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc5,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc6,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc7,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc8,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc9,
              style: generalfontStyle,
            ),
            SizedBox(height: space_between),
            Text(
              localizations.tnc10,
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
