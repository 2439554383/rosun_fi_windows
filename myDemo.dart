void main() {
  //解构
  // List<dynamic> myList = [1,2,3];
  // var [a,b,_] = myList;
  // print(a);
  // print(b);

  // Map<String,dynamic> myMap = {"a":1,"b":2,"c":3};
  // var {"a":b,"c":d} = myMap;
  // print(b);

  //合并
  // String aS = "Hello";
  // String bS = "Word";
  // List<dynamic> aL = [1,2,3];
  // List<dynamic> bL = [4,5,6];
  // final cL = aL+bL;
  // print(aS+" "+bS);

  //递增数字
  // List<int> numbers = [];
  // for(int i =1;i<=60;i++){
  //   numbers.add(i);
  // }
  // List<int> numbers = List.generate(60, (index) => index + 1);
  // print(numbers);

  //柯里化
  // Function mul(int x) =>
  //     (int y) => x * y;
  // Function number = mul(2);
  // final number1 = number(5);
  // final number2 = number(10);
  // print(number1);
  // print(number2);

  //空感知
  // String? a;
  // String? b;
  // String c = "1";
  // final List = [?a,?b,c];
  // print(List);
}
