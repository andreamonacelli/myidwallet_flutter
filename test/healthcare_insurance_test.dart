import 'package:test/test.dart';
import 'package:myidwallet_flutter/models/entities/healthcare_insurance.dart';

void main(){
  group("HealthcareInsurance internal methods testing", () {
    /* Test for parseTesseraSanitariaText() */
    test("Parsing text from a huge string representing data fetched from a Tessera Sanitaria image", () {
      HealthcareInsurance target = HealthcareInsurance();
      String targetText = """
      MONACELLI
      ANDREA
      17/06/2002
      SSN-MIN SALUTE - 12345
      MNCNDR02H17F257N
      12345678901234567890
      31/12/2025
      """;
      final parseResult = target.parseTesseraSanitariaText(targetText);
      expect(parseResult["Unique Code"], "MNCNDR02H17F257N");
      expect(parseResult["Cognome"], "MONACELLI");
      expect(parseResult["Expiry Date"], "31/12/2025");
      expect(parseResult["Numero di identificazione della tessera"], "12345678901234567890");
    });

    /* Test for codiceFiscaleTypoFixing() */
    test("Checking and eventually correcting strings representing a Codice Fiscale", () {
      HealthcareInsurance target = HealthcareInsurance();
      expect(target.codiceFiscaleTypoFixing("ABCDEF12G34H567I"), "ABCDEF12G34H567I");
      expect(target.codiceFiscaleTypoFixing("Z0CVBN45M67N89O0"), "ZOCVBN45M67N890O");
      expect(target.codiceFiscaleTypoFixing("ZXCVBN45M67N890O"), "ZXCVBN45M67N890O");
      expect(target.codiceFiscaleTypoFixing("MNCNDRO2H17F257N"), "MNCNDR02H17F257N");
    });

    /* Test for discardStringIT() */
    test("Checking whether the current string should be discarded", () {
      HealthcareInsurance target = HealthcareInsurance();
      expect(target.discardStringIT("3 Cognome"), true);
      expect(target.discardStringIT("Keep me"), false);
      expect(target.discardStringIT("6 Numero identificazione personale"), true);
      expect(target.discardStringIT("3 Cognme"), true);
      expect(target.discardStringIT("String to keep"), false);
      expect(target.discardStringIT("TESSERA ROPEA DI ASSCURAZIONE MALTTIA"), true);
    });
  });
}