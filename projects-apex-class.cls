1. Teenager
Use case: Given a person's age, return true if the person is a teenager (age 13 - 19).

public Boolean isTeenager(Integer age) {
    if((age => 13) && (age <= 19)){
        return true;
    }else{
        return false;
    }
}

 
2. Number Difference
Use case: Implement a function diff that calculates the absolute difference between two integers.

public Integer diff(Integer a, Integer b) {
   Integer result = a-b;
   return Math.abs(result);
}


3. Sum Equals
Use case: Given Integers a, b, and c, return true if a and b add up to c.

public Boolean sumEquals(Integer a, Integer b, Integer c) {
   Integer z = a+b;

   if(z == c){
       return true;
   }else{
       return false;
   }
}


4. Ascending Order
Use case: Given three Integers a, b, and c, return true if they are in ascending order. For our purposes, two equal numbers will be considered to be in an ascending order.

public Boolean ascendingOrder(Integer a, Integer b, Integer c) {
    if(a == b || a<b && b<c && a<c){
        return true;
    }else if(b>a){
        return false;
    }else{
        return false;
    }
}


5. A or An
Use case: Given a work, prepend it with the correct indefinite article ("a" or "an") followed by a space based on the following rule: words starting with a vowel (a, e, i, o, or u) are prepended with "an", while words starting with any other letter are prepended with "a".

public String aOrAn(String word) {
    if( word.startsWith('a')  || 
        word.startsWith('e') ||
        word.startsWith('i') ||
        word.startsWith('o') ||
        word.startsWith('u') ){
        return 'an '+word;
    }else{
        return 'a '+word;
    }
}


6. Largest of Three
Use case: Given three Integers, return the largest

public static Integer findLargest(Integer num1, Integer num2, Integer num3) {
	Integer num4 = Math.max(num1, num2);
    if(num4>num3){
        return num4;
    }else{
        return num3;
    }
}


7. Passing Students
Use case: A student passes a course if any two of the following three conditions are true: they have passed the exam, they have passed assignments, and they have passed the course project.
         Implement the function isPassed that takes in three parameters passedExam, passedAssignments, and passedProject, and returns true of at least two of the passed variables are true.
         isPassed(true, false, true) = true. Student did not pass assignments, but passes overall because they passed the exam and the project.
         isPassed(false, false, true) = false. Student only passed the project, and therefore does not pass overall.

public Boolean isPassed(Boolean passedExam, Boolean passedAssignments, Boolean passedProject) {
    if(passedExam && passedAssignments){
        return true;
    }else if(passedExam && passedProject){
        return true;
    }else if(passedAssignments && passedProject){
        return true;
    }else{
        return false;
    }
}


8. Ends With 0
Use case: Given an integer, return true if the integer ends with 0, otherwise return false.

public Boolean isEndWithZero(Integer num){

     if(Math.mod(num,10) == 0){
         return true;
     }else{
         return false;
     }
}


9. Which two
Use case: Given Integers a, b, and c, determine if any two of them add up to the third and return 'a', 'b', 'c' depending on which the sum is. If no two numbers add up to a third number, return an empty string. Assume that multiple solutions do not exist.

public String whichTwo(Integer a, Integer b, Integer c) {
    if(a+b == c){
        return 'c';
    }else if(a+c == b){
        return 'b';
    }else if(b+c == a){
        return 'a';
    }else{
        return '';
    }

}


10. Even or odd
Use case: Given an Integer, return 'even' if the Integer is even, or 'odd' if the Integer is odd. Remember to use the Math.mod function.

public String evenOrOdd(Integer num) {
    if(Math.mod(num,2) == 0){
        return 'even';
    }else{
        return 'odd';
    }
}


11. Rock Paper Scissors
Use case: Rock beats scissors, scissors beat paper, paper beats rock. 
	Implement the method rockPaperScissors that takes as parameters two strings player1 and player2 representing the moves played by player 1 and player 2, 
	valid moves being 'rock', 'paper', and 'scissors'. Return 1 if player 1 wins, 2 if player 2 wins, and 0 if no one wins.

public Integer rockPaperScissors(String player1, String player2) {
    if (player1 == player2) {
        return 0;
    } else if (((player1 == 'rock') && (player2 == 'scissors')) ||
               ((player1 == 'scissors') && (player2 == 'paper')) ||
               ((player1 == 'paper') && (player2 == 'rock'))) {
        return 1;
    } else {
        return 2;
    }
}


14. Bucket Based on Age
Use case: Given a person's age, return their age group as a string: 'Infant' for ages 0-1, 'Child' for ages 2 - 14, 'Youth' for ages 15 - 21, and 'Adult' for ages 22+

public String ageGroup(Integer n) {
  if((n == 0) || (n == 1)){
      return 'Infant';
  }else if((n >= 2) && (n <= 14)){
      return 'Child';
  }else if((n >= 15) && (n <= 21)){
      return 'Youth';
  }else{
      return 'Adult';
  }
}


15. Companion Plants
Use case: Some plants are considered companion plants. They grow better when planted next to each other. For the purpose of this problem, we consider the following plants to be companions: 
	  lettuce and cucumbers, lettuce and onions, onions and carrots, and onions and tomatoes.
	  Write a function isCompanion that takes as input two strings plant1 and plant2. If the two plants are companion plants based on the criteria described above, return true. Otherwise, return false.

public Boolean companionPlants(String plant1, String plant2) {
 map<String,String> companionMap = new map<String,String>{
        'cucumbers' => 'lettuce',
        'onions' => 'lettuce',
        'carrots' => 'onions',
        'tomatoes' => 'onions'
    };
    if ((companionMap.get(plant1) == plant2) ||
        (companionMap.get(plant2) == plant1)) {
        return true;
    } else {
        return false;
    }
}


16. Leap Year
Use case: A year is considered a leap year if it is evenly divisible by 4, with the exception of years that are also evenly divisible by 100. 
	  Years evenly divisible by 100 must also be evenly evenly divisible by 400 to by considered leap years. 
	  Implement a method isLeapYear that takes as input an Integer year and returns true if the year is a leap year, and false otherwise.

public Boolean isLeapYear(Integer year) {
    if(Math.mod(year, 4) == 0){
        if(Math.mod(year, 100) == 0){
            if(Math.mod(year, 400) == 0){
                return true;
            }else{
                return false;
            }
        }else{
            return true;
        }
    }else{
        return false;
    }
}


17. Prime Number
Use case: A prime number is a number greater than 1 that is not evenly divisible by any number greater than one and smaller than itself. For example, 13 is a prime number because it is not evenly divisible by any number between 1 and 13.
	  Implement the function isPrime that takes as input an integer greater than 1, returns true if the integer is a prime number, and returns false otherwise. Assume that the input will always be greater than 1.
	  isPrime(10) = false. 10 is not a prime number because it is evenly divisible by 2 and 5.
	  isPrime(23) = true. 23 is a prime number because it is not evenly divisible by any number from 2 to 22.

public Boolean isPrime(Integer num) {
   for(Integer i=2; i< num; i++){
       if(Math.mod(num, i) == 0){
           return false;
       }
   }
    return true;
}


18. Sum 1 to N
Use case: Implement the method sumToN that calculates and returns the sum of all numbers (inclusive) from 1 to n. Assume that n will be non-zero positive integer.

public Integer sumToN(Integer n) {
    Integer sum = 0;
    for(Integer i=0; i<= n; i++){
        sum+= i;
    }
    return sum;
}


19. Full Name
Use case: Given two non-empty strings firstName and lastName, return the name as a single string with a space in between (firstName lastName). formatName('Jane', 'Doe') = 'Jane Doe'

public String formatName(String firstName, String lastName) {
    return fullName = firstName +' '+lastName;
}


20. Format Name
Use case: Given two strings firstName and lastName, return the name in the format LastName, FirstName. In case one of the names is null or empty, return only the non-

public String formatName(String firstName, String lastName) {
    if(String.isBlank(firstName) && String.isBlank(lastName)){
        return '';
    }else if(String.isBlank(firstName)){
        return lastName;
    }else if(String.isBlank(lastName)){
        return firstName;
    }else{
        return lastName +', '+firstName;
    }
}


21. Name from Email
Use case: Implement a function nameFromEmail that takes as input a valid email address in the format firstname.lastname@example.com. The function should extract the first name and last name from this email address and return a capitalized full name (i.e. FirstName LastName). Assume that the input will always be a valid email address with both the first name and last name separated by a period (.).
	  nameFromEmail('john.doe@apexsandbox.io') = 'John Doe'
	  nameFromEmail('JANE.DOE@GMAIL.COM') = 'Jane Doe'

public String nameFromEmail(String email) {
    String firstName = email.substringBefore('.').toLowerCase().capitalize();
    String lastname =  email.substringBetween('.', '@').toLowerCase().capitalize();
    return firstName+' '+lastname;
}


22. Change Time Format+
Use case:

public String changeTimeFormat(String strTime) {
    String hour = strTime.substringBefore(':');
    String min = strTime.substringAfter(':');
    Integer intH = Integer.valueOf(hour);

    if(intH == 0){
        return '12:'+ min + ' AM';
    }else if(intH < 12){
        return hour +':'+ min + ' AM';
    }else if(intH == 12){
        return '12:'+ min +' PM';
    }else{
        intH -=12;
        hour = String.valueOf(intH).leftPad(2,'0');
        return hour+':'+min+' PM';
    }
}


23. Fibonacci
Use case: The first two numbers in the Fibonacci sequence are 1, and all other numbers in the sequence are defined as the sum of the last two Fibonacci numbers. The first 10 numbers in the Fibonacci sequence are 1, 1, 2, 3, 5, 8, 13, 21, 34, and 55.
	  Implement the function Fibonacci that takes as input an Integer n and returns the nth Fibonacci number. Assume that n will always be greater than 0.

public Integer fibonacci(Integer n) {
    Integer t = 0;
    Integer l = 1;
    Integer c = 1;
    for (Integer i = 3; i <= n; i++) {
        t = c;
        c += l;
        l = t;
    }
    return c;
}


24. Reverse Order of Words
Use case: Implement a function reverseWordsInASentence that will take a String containing words separated by spaces as an argument, and return a string with the order of the words reversed.
          Example : If the sentence is The quick brown fox jumps over the lazy dog, then reverseWordsInASentence(String sentence) should evaluate to dog lazy the over jumps fox brown quick The

public String reverseWordsInASentence(String sentence){
    if(sentence == null){
        return null;
    }else if(sentence == ''){
        return '';
    }
    
    List<String> word = sentence?.split(' ');
    String reversed = '';

    for(Integer i=word.size()-1; i>= 0; i--){
        if(reversed == ''){
            reversed += word[i];
        }else{
            reversed += ' '+word[i];
        }
    }
    return reversed;
}


25. Next Prime
Use case: A prime number is a number greater than 1 that is not evenly divisible by any number greater than one and smaller than itself. For example, 13 is a prime number because it is not evenly divisible by any number from 2 to 12.
	  Implement the function nextPrime that takes as input an integer num and returns the smallest prime number greater than num.
	  nextPrime(10) = 11. 11 is the smallest prime number greater than 10
	  nextPrime(8) = 11. 11 is the smallest prime number greater than 8

if (num < 2) {
        return 2;
    }

    Integer candidate = num + 1;
    while (!isPrime(candidate)) {
        candidate += 1;
    }
    return candidate;
}

public Boolean isPrime(Integer candidate) {
    for (Integer i = 2; i < candidate; i++) {
        if (Math.mod(candidate, i) == 0) {
            return false;
        }
    }
    return true;


