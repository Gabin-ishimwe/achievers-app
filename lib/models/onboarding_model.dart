class OnboardingModel {
  String description;
  var image;

  OnboardingModel({required this.description, required this.image});
}

List<OnboardingModel> onboardContents = [
  OnboardingModel(
      description: "Manage your daily tasks with Achievers",
      image: "onboarding_screen/onboarding_1.png"),
  OnboardingModel(
      description: "Easily track your productivity with Achievers",
      image: "onboarding_screen/onboarding_2.png"),
  OnboardingModel(
      description: "Boost your productivity with Achievers",
      image: "onboarding_screen/onboarding_3.png")
];
