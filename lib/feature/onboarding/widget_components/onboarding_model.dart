class OnboardingModel {
  final String title;
  final String describtion;
  final String imagePath;

  OnboardingModel(this.title, this.describtion, this.imagePath);
}

List<OnboardingModel> onBoardInfo = [
  OnboardingModel(
    'Overview',
    'it is an application that helps people find their missing or stolen item.',
    'https://img.freepik.com/free-vector/cyber-criminal-hacking-into-email-server_1262-20632.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais',
  ),
  OnboardingModel(
    'Objectives',
    'enable our customers, through this application to enter the code of the mobile phone or laptop,or the chassis number of cars and motorcycle, in order to find them if they were missing or stolen as it is an application that provides the ability to search for the missing things',
    'https://img.freepik.com/free-vector/flat-man-with-mobile-phone-scanning-qr-code-online-payment-internet-shopping-characters-standing-near-big-smartphone-with-qr-symbol-device-screen-using-scanner-id-app-pay_88138-815.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais',
  ),
  OnboardingModel(
    'Purpose',
    'By allownig the customers to find their missing or stolen items, our customer will feel morecomfortable and more safer when they lost anything because they can search for it easlyand find where they lost it and also our system allows the customer to sell or buy any item insidethe application if it is not stolen.',
    'https://img.freepik.com/free-vector/shopping-payment-online-process-computer-smartphone-tablet_24797-1574.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
  ),
];
