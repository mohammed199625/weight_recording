import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:weight_recording/model/weight_model.dart';

class WeightRepository {
  final _fireCloud = FirebaseFirestore.instance.collection("weights");

  Future<void> create({required String name, required String weight}) async {
    try {
      await _fireCloud.add({"name": name, "weight": weight});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<WeightModel>?> get() async {

    List<WeightModel> weightModelList =[];

    try {

      final weightModel = await FirebaseFirestore.instance.collection("weights").get();

      weightModel.docs.forEach((element) {
        return weightModelList.add(WeightModel.fromJson(element.data()));
      });

      return weightModelList;
    }
    on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<void> delete()async{
    var collection = FirebaseFirestore.instance.collection("weights");
    var snapShots =await collection.get();
    for(var doc in snapShots.docs){
      await doc.reference.delete();
    }

  }



}
