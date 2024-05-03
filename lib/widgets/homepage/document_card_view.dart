import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/models/entities/document_type.dart';
import 'package:myidwallet_flutter/models/entities/driving_license.dart';
import 'package:myidwallet_flutter/models/entities/healthcare_insurance.dart';
import 'package:myidwallet_flutter/models/entities/passport.dart';
import 'package:myidwallet_flutter/models/entities/personal_id.dart';

class DocumentCardView extends StatelessWidget {

  late final Document _boundDocument;

  @override
  Widget build(BuildContext context) {
    String backgroundImageResource = _boundDocument.placeholderBGImage;
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 6,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImageResource),
          fit: BoxFit.fill,
        ),
      ),
      child: FloatingActionButton(
        onPressed: () => print("Card for document ${_boundDocument.documentHolderName} has been pressed!"),
        child: Text(
          _boundDocument.documentHolderName,
          style: TextStyle(
            fontFamily: 'Baloo2',
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  String _parseCardBackgroundImage(){
    DocumentType? docType = _boundDocument.documentType;
    String backgroundResString = "";
    if(docType is HealthcareInsurance){
      backgroundResString += "healthcare";
    } else if(docType is DrivingLicense){
      backgroundResString += "drivinglic";
    } else if(docType is Passport){
      backgroundResString += "passport";
    } else if(docType is PersonalID){
      backgroundResString += "idcard";
    }
    backgroundResString += ("_${_boundDocument.documentNation}.png");
    return backgroundResString;
  }
}