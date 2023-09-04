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


14. Given a person's age, return their age group as a string: 'Infant' for ages 0-1, 'Child' for ages 2 - 14, 'Youth' for ages 15 - 21, and 'Adult' for ages 22+.










