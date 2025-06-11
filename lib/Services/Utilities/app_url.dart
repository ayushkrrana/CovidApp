//HERE WE ALL DEFINED THE URLS WE USED IN OUR APP SO THAT IT CAN BECOME EASY TO USE THE URL IN ONE PLACE

class AppUrl{
  // when we use static in data class member it means we can access it without creating the object of the class
  /*
  EXAMPLE-
    class MyUtils {
  static int counter = 0;

  static void sayHello() {
    print("Hello from static method!");
  }
}
so we can access it directly with the classname without creating the object
void main() {
  print(MyUtils.counter);       // prints 0
  MyUtils.sayHello();           // prints Hello from static method!
}
   */

  //Now below we create the url of apis

  //its our base url
  static const String baseUrl='https://disease.sh/v3/covid-19/';

  //fetch the world covid states
static const String worldStatesApi= baseUrl+ 'all'; //it will do the https://disease.sh/v3/covid-1/9/all it concatenate the base url to fetch other datas
static const String countriesList =baseUrl+ 'countries';  //all and countries are API endpoints, and you’re just appending them to the base URL using string concatenation.




}