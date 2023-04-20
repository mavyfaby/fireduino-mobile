import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final currentStep = 0.obs;
  final maxStep = 0.obs;
  final firstName = "".obs;
  final lastName = "".obs;
  final email = "".obs;
  final password = "".obs;

  void nextStep() {
    if (currentStep.value < 2) {
      maxStep.value++;
      currentStep.value++;
    }
  }

  void prevStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void reset() {
    currentStep.value = 0;
    maxStep.value = 0;
    firstName.value = "";
    lastName.value = "";
    email.value = "";
    password.value = "";
  }
}