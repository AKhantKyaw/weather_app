
import 'dart:convert';

Errormodel errormodelFromJson(String str) => Errormodel.fromJson(json.decode(str));

String errormodelToJson(Errormodel data) => json.encode(data.toJson());

class Errormodel {
    Errormodel({
      required  this.cod,
      required  this.message,
    });

    String cod;
    String message;

    factory Errormodel.fromJson(Map<String, dynamic> json) => Errormodel(
        cod: json["cod"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
    };
}
