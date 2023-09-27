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


26. Insert Student
Use case: The method insertStudent takes as input strings name and email, and returns a record ID. Implement the method to insert an apxio__Student__c record with the Name and apxio__Email__c fields filled out, and return the Id of the new record.

public Id insertStudent(String name, String email) {
   apxio__Student__c stu = new apxio__Student__c();
   stu.name = name;
   stu.apxio__Email__c = email;
   insert stu;

   return stu.id;
}


27. Insert Course
Use case: The method insertCourse takes as input strings name and details, an integer credits, and returns a record ID. Implement the method to insert a apxio__Course__c record with the Name and apxio__Course_Details__c and apxio__Credits__c fields filled out, and return the Id of the new record.
	  Note thatapxio__Credits__c is a restricted picklist with valid values 1, 2, 3, and 4. If an invalid value is provided for this picklist, return null.
	  You will be working with the following custom object and field names for this problem:

public Id insertCourse(String name, String details, Integer credits) {
    apxio__Course__c course = new apxio__Course__c();
    course.name = name;
    course.apxio__Course_Details__c = details;
    course.apxio__Credits__c = String.valueOf(credits);
    try{
        insert course;
    }catch(Exception e){
        return null;
    }
    return course.id;
}


28. Register Student
Use case: The method registerStudent takes as input strings name, phone and email, and returns a string. Implement the method to insert an apxio__Student__c record with the Name, apxio__Phone__c and apxio__Email__c fields filled out, and return the autogenerated apxio__Registration_Number__c of the new record.

public String registerStudent(String name, String phone, String email) {
    apxio__Student__c student = new apxio__Student__c();
    student.name = name;
    student.apxio__Email__c = email;
    student.apxio__Phone__c = phone;
    insert student;

    apxio__Student__c stuReg = [Select apxio__Registration_Number__c from apxio__Student__c where Id =:student.Id];
    return stuReg.apxio__Registration_Number__c;
}


29. Active Students
Use case: Implement the method selectActiveStudents that returns a list of all apxio__Student__c records with apxio__Active__c field checked. Make sure the students have a value in the Id and Name fields.

public List<apxio__Student__c> selectActiveStudents() {
    List<apxio__Student__c> stuList = [Select Id, Name 
                                       from apxio__Student__c 
                                       where apxio__Active__c = true
                                       order by Name];
    return stuList;
}


30. Unreachable Students
Use case: Implement the method selectUnreachableStudents that queries for and returns a list of all active apxio__Student__c records that are unreachable because they are missing both an email and a phone number. Make sure to include the Id and Name fields in the result. The returned list should be sorted A-Z on Name

public List<apxio__Student__c> selectUnreachableStudents() {
    List<apxio__Student__c> unreachableStudents = [Select Id, Name 
                                                   From apxio__Student__c
                                                   where apxio__Active__c = true 
                                                   and apxio__Email__c = null 
                                                   and apxio__Phone__c = null
                                                   order by Name
                                                   limit 1]
    return unreachableStudents;                                         
}


31. Students Missing Info
Use case: Implement the method selectStudentsWithoutContactInfo that queries for and returns a list of all active apxio__Student__c records that are missing an email, phone, or both. Make sure to include the Id and Name fields in the result. The returned list should be sorted A-Z on Name.

public List<apxio__Student__c> selectStudentsWithoutContactInfo() {
    List<apxio__Student__c> students = [Select Id, Name
                                        from apxio__Student__c
                                        where apxio__Active__c = true
                                        and apxio__Email__c = null
                                        or apxio__Phone__c = null
                                        or (apxio__Phone__c and apxio__Email__c order by Name)];
    return students
}

32. Course and Class
Use case: The method createCourseAndClass takes as input string parameters courseName and description, and returns void. Provide an implementation of the method that first inserts a apxio__Course__c record with the provided name and description (if provided) copied into the Name and apxio__Course_Details__c fields, and then inserts a child apxio__Class__c record with the same name and description copied into the Name and apxio__Description__c fields.
	  There is, however, a difference between the course details and description fields on the two objects. While the apxio__Course__c.apxio__Course_Details__c has type Rich Text capable of storing thousands of characters, apxio__Class__c.apxio__Description__c can only store a maximum of 255 characters. Make sure to truncate the description to 255 characters before adding it to your apxio__Class__c record. You can assume that the provided description will never be too large for the rich text field.

public void createCourseAndClass(String name, String description) {
    apxio__Course__c course = new apxio__Course__c();
    course.name = name;
    course.apxio__Course_Details__c = description;
    insert course;

    apxio__Class__c classes = new apxio__Class__c();
    apxio__Class__c.apxio__Course__c = course.Id;
    classes.Name = name;
    classes.apxio__Description__c = description?.left(255);
    insert classes;
}


33. Student List
Use case: The method insertStudents takes as input two lists of strings studentNames and studentEmails. The two lists will always have the same size, with studentNames[i] and studentEmails[i] (for any in-range value of i) representing a student's name and email.
	  Write an implementation of the method that creates apxio__Student__c records for each entry in the lists with the Name and apxio__Email__c fields filled out.

public void insertStudents(List<String> studentNames, List<String> studentEmails) {
    List<apxio__Student__c> stus = new List<apxio__Student__c>();

    for(Integer i=0; i<studentNames.size(); i++){
        apxio__Student__c student = new apxio__Student__c();
        student.name = studentNames[i];
        student.apxio__Email__c = studentEmails[i];
        stus.add(student);
    }
    insert stus;
}


34. Class from Course
Use case: Implement the method classFromCourse that takes as input a string courseName, creates an apxio__Class__c record associated with the course named courseName, and returns the Id of the new record. The new class should have the same Name as the course.
	  You should not create a new apxio__Course__c record. The new class should be linked to the course that already exists in the database. In case no course with the given name is found, do not create any class record and return null.

public Id classFromCourse(String courseName) {
    List<apxio__Course__c> course = [Select Id, name from apxio__Course__c where apxio__Course__c =: courseName];

    if(course.isEmpty()){
        return null;
    }
    
    apxio__Class__c cl = new apxio__Class__c();
    cl.name = course[0].Name;
    cl.apxio__Course__c = course[0].id;
    insert cl;

    return cl.id;
}


35. Enroll Students
Use case: Implement the method enrollStudents that takes as input a list of strings emails and a string className and returns a boolean. The method should enroll all students with the provided emails into a class with the given name by creating apxio__Class_Enrollment__c records.
          Note that apxio__Student__c and apxio__Class__c records already exist in the database

public void enrollStudents(List<String> emails, String className) {
    List<apxio__Student__c> stu = [Select Id, apxio__Email__c from apxio__Student__c where apxio__Email__c in: emails];
    List<apxio__Class__c> cls = [Select Id, Name from apxio__Class__c where apxio__Class__c =: className];
    List<apxio__Class_Enrollment__c> enrs = new List<apxio__Class_Enrollment__c>();

    for(Integer i=0; i< stu.size(); i++){
        apxio__Class_Enrollment__c enr = new apxio__Class_Enrollment__c();
        enr.apxio__Student__c = stu[i].id;
        enr.apxio__Offered_Class__c = cls[i].id;

        enrs.add(enr);
    }
    if(enrs.size()>0){
        insert enrs;
    }
}


36. sObject Type
Use case: Implement the method isTypeAccount(), which accepts a sObject as input and returns a true if type of input is Account object else it should return as false.

public Boolean isTypeAccount(sObject record){
   if(record instanceOf Account){
       return true;
   }
       return false;
}


37. Convert 15-digit ID to 18-digit ID
Use case: Implement the method convert15to18DigitId() , which accepts a String of length 15 digit and returns a new String with 18 digit salesforce Id. If the input string length is not equal to 15 digits, then return '-1'.
	  Given the following test code:
	  String fifteenDigit = '0SO90000000PBDu';
	  String eighteenDigit = convert15to18DigitId(fifteenDigit);
	  eighteenDigit should be equal to '0SO90000000PBDuGAO'

public String convert15to18DigitId(String fifteenDigit){
    if(fifteenDigit?.length() == 15){
        return (id)fifteenDigit;
    }
        return '-1';
}


38. Handle Exception
Use case: Implement the method divide which takes two integers a and b as input, divides a by b using the / operator, and returns the result. If any exception occurs, the method should return the exception message.

public String divide(Integer a, Integer b){
    try{
        return String.valueOf(a/b);
    }catch(Exception e){
        return e.getMessage();
    }
}


39. Throw An Exception
Use case: Implement the method checkAccounts, which accepts a list of accounts as an input and returns a list of accounts. The method should behave as follows:
	  If all accounts in the list have BillingCity present, the method should return the original list.
          If the passed list is null the method should throw the built-in IllegalArgumentException with message 'accounts should not be null'
          If any of the accounts in the list do not have a BillingCity present, the method should throw the custom AccountException exception with message 'Invalid BillingCity'. Do not create new exception class - use the AccountException class that has already been created for you.
          Given the following test code:
          List<Account> accounts = new List<Account>();
          accounts.add(new Account(name ='Salesforce', BillingCity ='Boston'));
          accounts.add(new Account(name ='Microsoft'));

public List<Account> checkAccounts(List<Account> accounts){
    if(accounts == null){
        throw new IllegalArgumentException('accounts can not be null');
    }
    for(Account a : accounts){
        if(a.BillingCity == null){
            throw new AccountException('BullingCity is not valid');
        }
    }
    return accounts;
}

public class AccountException extends Exception {}


40. Safe Navigation Operator
Use case: Implement the method getAccountBillingCityWithSafeNavigation, which accepts a list of accounts as an input and returns the BillingCity in upper case of the first account in the list. Use the Safe Navigation (?.) to ensure null is returned in case the BillingCity is null.
          Given the following test code:

public String getAccountBillingCityWithSafeNavigation(List<Account> accounts){
   String billingC = accounts[0].BillingCity?.toUpperCase();
   return billingC;
}


41. Dynamic Field Values
Use case: Implement the method getFieldsValue, which accepts the following inputs:
          An account acc
	  A list of strings fields, with each string in the list representing a valid field on the account object.
	  The method should return a list of values from the account record for fields listed in the list fields in the correct order.

public List<String> getFieldsValue(Account acc, List<String> fields){
   List<String> results = new List<String>();

   for(String field : fields){
       String result = String.valueOf(acc.get(field));
       results.add(result);
   }
   return results;
}


42. Serialize sObjects
Use case: Implement the method getAccountsInJSONFormat(), a list of accounts and returns a list of accounts in string JSON format.

public String getAccountsInJSONFormat(List<Account> accounts){
  String JSONString = JSON.serialize(accounts);
  return JSONString;
}


43. List of sObjects
Use case: Implement the method getListOfsObject(), which accepts two parameters, a list of accounts, and a list of contacts, as an input and returns a list of sObjects. If both lists are empty or null, return an empty list of sObject.

public List<sObject> getListOfsObject(List<Account> accounts, List<Contact> contacts){
    List<sObject> objects = new List<sObject>();
    
    if(accounts != null){
        for(Account a : accounts){
            objects.add(a);
        }
    }
    if(contacts != null){
        for(Contact c : contacts){
            objects.add(c);
        }
    }
    return objects;
}


44. Deserialize sObjects
Use case: Implement the method getAccountsFromJSONString, which takes a JSON string of a list of accounts as an input and returns a list of accounts. If the input string is empty or null, return null.

public List<Account> getAccountsFromJSONString(String inputJSON){
    List<Account> acList = new List<Account>();
    if(inputJSON == null || inputJSON == ''){
        return null;
    }else{ 
        return(List<Account>) JSON.deserialize(inputJSON, List<Account>.class);
    }
}


45. Context User
Use case: Implement the method getContextUserInformation(), which returns a Map of the current logged in user's (context user's) UserName, ProfileId, EmailId, and Type as keys and their field values as corresponding values in the map. 

public Map<String,String> getContextUserInformation(){
   return new Map<String,String>{
       'EmailId'=> UserInfo.getUserEmail(),
       'UserName' => UserInfo.getUserName(),
       'ProfileId' => UserInfo.getProfileId(),
       'Type' => UserInfo.getUserType()
   };
}


46. Trigger Validation
Use case: Implement the method validateInsert, which accepts a newly inserted list of opportunities as an input and adds errors to the opportunity fields as follows: if the opportunity record's StageName is 'Closed Won' and the Description is null or empty, add an error on the Description field of that record with the error message set to 'Description should not be empty for Closed Won opportunity.'

public void validateInsert(List<Opportunity> opportunities){
    for(Opportunity o : opportunities){
        if(o.StageName == 'Closed Won' && (o.Description == null || o.Description == '' )){
            o.Description.addError('Description should not be empty for Closed Won opportunity.');
        }
    }
}


47. Sort List of sObjects
Use case: Implement the method getAccounts(), function, which accepts a list of accounts as input and returns a new list of accounts sorted in descending order based on the Annual Revenue field.

public List<Account> getAccounts(List<Account> accounts) {
    if(accounts == null) {
        return null;
    }

    List<AccountWrapper> accList = new List<AccountWrapper>();

    for(Account acc : accounts) {
        accList.add(new AccountWrapper(acc));
    }

    accList.sort();

    for(Integer i=0; i<accounts.size(); i++) {
        accounts[i] = accList[i].acc;
    }
    
    return accounts;
}

public class AccountWrapper implements Comparable {
    public Account acc; 

    public AccountWrapper(Account acc) {
        this.acc = acc;
    }

    public Integer compareTo(Object compareTo) {
        AccountWrapper aw = (AccountWrapper) compareTo;

        if (aw.acc.AnnualRevenue > this.acc.AnnualRevenue) {
            return 1;
        }

        return -1;
    }
}


48. Duplicate Contacts
Use case: For this problem, we consider two Contacts as duplicates if they have the same phone number or the same email address.
	  Implement the method duplicateContacts that takes as input two Contact records c1 and c1, returns true if they are duplicates, and returns false otherwise.

public Boolean duplicateContacts(Contact c1, Contact c2) {
    return (c1.Email != null && c1.Email == c2.Email) ||
            (c2.Phone != null && c1.Phone == c2.Phone); 
}


49. Account Rating
Use case: Implement a method setAccountRating that looks at an Account's AnnualRevenue, and sets the value of the Rating picklist field based on the following criteria:
	  Accounts with AnnualRevenue less than or equal to 100,000 get a rating of "Cold"
          Accounts with AnnualRevenue less than or equal to 500,000 but greater than 100,000 get a rating of "Warm"
          Accounts with AnnualRevenue greater than 500,000 get a rating of "Hot"

public void setAccountRating(Account a) {
     if(a.AnnualRevenue <= 100000){
           a.Rating = 'Cold';
       }else if(a.AnnualRevenue <= 500000){
           a.Rating = 'Warm';
       }else if(a.AnnualRevenue > 500000){
           a.Rating = 'Hot';
       }
}


50. Contact Birthday
Use case: Given a Contact with the Birthdate field set to some date, return true if today is the Contact's birthday and return false if not. Assume that a future date will not be set on the Birthdate field.

public Boolean isBirthday(Contact c) {
  Date t = System.today();
  return c.Birthdate.month() == t.month() && c.Birthdate.day() == t.day();
}


51. Key Account
Use case: For this problem, we define minimum annual revenue thresholds an account must meet to be considered a key account. The annual revenue thresholds are defined by industry:
	  Banking: 600,000
	  Technology: 800,000
	  Retail: 2,000,000
	  All others: 500,000
	  Implement the method isKeyAccount that takes as input an Account with the AnnualRevenue field and the Industry picklist fields filled out, returns true if the account is a key account, and returns false otherwise.

public Boolean isKeyAccount(Account a) {
    if(a.Industry == 'Banking' && a.AnnualRevenue == 600000){
        return true;
    }else if(a.Industry == 'Technology' && a.AnnualRevenue == 800000){
         return true;
    }else if(a.Industry == 'Retail' && a.AnnualRevenue == 2000000){
         return true;
    }else if(a.Industry != null && a.AnnualRevenue == 500000){
         return true;
    }else{
        return false;
    }
}


52. Escalate Case
Use case: In-progress cases dealing with mechanical or electrical breakdown need to be escalated. Implement a method escalateIfMeetsCriteria that takes as input a Case record, and sets the IsEscalated field to true if Type is Mechanical or Electrical, Reason is Breakdown, and Status is In Progress

public void escalateIfMeetsCriteria(Case c) {
    if((c.Type == 'Mechanical' || c.Type == 'Electrical') && c.Reason == 'Breakdown' && c.Status == 'In Progress'){
        c.isEscalated = true;
    }
}


53. Same Parent
Use case: Implement the method sameParent that takes as input an opportunity opp and a contact c, and returns true if both the opportunity and contact have the same parent account.

public Boolean sameParent(Contact c, Opportunity opp) {
   if(c.AccountId == null || opp.AccountId == null){
       return false;
   }else if(c.AccountId == opp.AccountId){
       return true;
   }
       return false;
   
}


54. Same Parent II
Use case: Implement the method sameParent that takes as input an account acc, a contact con, and an opportunity opp and returns true if both the opportunity and contact have the given account as the parent.

public Boolean sameParent(Account acc, Contact con, Opportunity opp) {
    if(con.AccountId == null || opp.AccountId == null){
        return false;
    }else if(con.AccountId == acc.id && opp.AccountId == acc.id) {
        return true;
    }else {
        return false;
    }        
}


55. Set Parent Account
Use case: Implement the method setParent that takes as input an account acc, a contact con, and an opportunity opp and sets the account is the parent for both the opportunity and contact. Make sure to not take any action if the provided account or its Id is null.

public void setParent(Account acc, Contact con, Opportunity opp) {
    if(acc != null  && acc.id != null ){
        con.AccountId = acc.Id;
        opp.AccountId = acc.Id;
    }        
}


56. Set Parent Case
Use case: Implement the method linkParent that takes as input two cases c1 and c2, and sets the case created first as the parent of the case created later only if both cases look up to the same Contact. Ensure to handle the special case where the cases do not have any related contacts.

public void linkParent(Case c1, Case c2) {
        if (c1.ContactId != null && c2.ContactId != null) {
            if (c1.ContactId == c2.ContactId) {
                if (c1.CreatedDate < c2.CreatedDate) {
                    c2.ParentId = c1.Id;
                } else if(c1.CreatedDate > c2.CreatedDate){
                    c1.ParentId = c2.Id;
                }else{
                    c1.ParentId = null;
                    c2.ParentId = null;
                }
            }
        }
}


57. Sorting a List
Use case: Implement the method getNamesInAscOrder(), which accepts a list of fullnames as input and returns the list sorted in ascending order. Use the standard library method to sort.

public List<String> getNamesInAscOrder(List<String> accountNames){
    if(accountNames == null){
        return null;
    }
        accountNames.sort();
        return accountNames;
}


58. Array Sum
Use case: Implement the method arraySum that takes as input a non-empty list of Integers numbers, and returns the sum of all numbers in the list.
	  Example: arraySum(new List {5, 2, 3}) evaluates to 10.

public static Integer arraySum(List<Integer> numbers) {
    Integer sum = 0;
    if(numbers == null){
        return null;
    }

    for(Integer num : numbers){
        sum += num;
    }
    return sum;
}


59. Even Numbers
Use case: Given a non-zero positive integer n, return a list of the first n non-zero positive even numbers, ordered ascending.
	  Example: evenNumbers(5) returns a list containing the numbers 2, 4, 6, 8, 10.

public List<Integer> evenNumbers(Integer n) {
    List<Integer> nums = new List<Integer>();
    if(n > 0){
        Integer evenNum = 2;

        while(n > 0){
            nums.add(evenNum);
            evenNum+=2;
            n--;
        }
    }
    return nums;
}


60. Largest Element
Use case: Implement the method findLargest that takes as input a non-empty list of Integers nums, and returns the largest Integer in the list.
	  Example: findLargest(new List {5, 2, 8, 4, 2, 1}) evaluates to 8 because 8 is the largest Integer in the list.

public static Integer findLargest(List<Integer> nums) {
	Integer result = nums[0];

    if(nums == null){
        return null;
    }

    for(Integer n : nums){
        if(n > result){
            result = n;
        }
    }
    return result;
}


61. Positive Integers
Use case: A positive integer is defined as an integer greater than zero. Implement the method positiveIntegers that takes as input a list of integers numbers, and returns a new list with non-positive integers removed.
          Example: positiveIntegers(new List {2, -3, 6, 2}) returns a list containing the numbers 2, 6, 2.

public List<Integer> positiveIntegers(List<Integer> numbers) {
   List<Integer> positiveList = new List<Integer>();
   if(numbers == null){
       return null;
   }

   for(Integer n : numbers){
       if(n < 0){
           continue;
       }if(n>0){
           positiveList.add(n);
       }
   }
   return positiveList;
}


62. Consecutive Ones
Use case: Given a List of Integers containing only binary numbers (0 and 1), return the maximum number of consecutive 1s appearing in the List.

public Integer maxConsecutiveOnes(Integer[] numbers) {
    Integer max = 0;
    Integer curr = 0;

    if(numbers == null){
        return null;
    }

    for(Integer n : numbers){
        if(n == 1){
            curr++;
            max = Math.max(max, curr);
        }else{
            curr = 0;
        }
    }
    return max;
}


63. Insert at Beginning
Use case: Implement a method that would take an element and a List of elements as arguments and return the same List with the element inserted at the 0th position.

public void insertAtStart(String cityName, List<String> cities) {
    cities.add(null);
    
    for (Integer i = cities.size() - 2; i >= 0; i--) {
        cities[i + 1] = cities[i];
    }
    cities[0] = cityName;
}


64. Full Names
Use case: Implement the method fullNames that takes as input two equal-sized lists of strings firstNames and lastNames, and returns a new list containing full names, with each full name generated by the concatenating the first name and last name at the corresponding location in the input lists.

public List<String> fullNames(List<String> firstNames, List<String> lastNames) {
    List<String> fName = new List<String>();
    for(Integer i=0; i< firstNames.size(); i++){
        fName.add(firstNames[i] + ' ' + lastNames[i]);
    }
    return fName;
}


65. Companion Plants 2
Use case: Some plants are considered companion plants. They grow better when planted next to each other. For the purpose of this problem, we consider the following plants to be companions: lettuce and cucumbers, lettuce and onions, onions and carrots, and onions and tomatoes. The same plants planted next to each other are not considered companions.

public Boolean companionPlants(List<String> plants) {
    if (plants.size() == 0) return true;
    if (plants.size() == 1) return false;
    
    for (Integer i=0; i<plants.size() - 1; i++) {  
        if (!companions(plants[i], plants[i+1])) 
            return false;
        }
            return true;
}

public Boolean companions(String plant1, String plant2) {
    if (plant1 == 'onions' && (plant2 == 'lettuce' || plant2 == 'carrots' || plant2 == 'tomatoes'))
        return true;
    else if (plant1 == 'lettuce' && (plant2 == 'cucumbers' || plant2 == 'onions'))
        return true;
    else if (plant1 == 'cucumbers' && plant2 == 'lettuce')
        return true;
    else if (plant1 == 'carrots' && plant2 == 'onions')
        return true;
    else if (plant1 == 'tomatoes' && plant2 == 'onions')
        return true;
    else return false;
}


66. Fibonacci Series
Use case: The first two numbers in the fibonacci sequence are 1, and all other numbers in the sequence are defined as the sum of the two preceding fibonacci numbers. The first 10 numbers in the fibonacci sequence are 1, 1, 2, 3, 5, 8, 13, 21, 34, and 55.
	  Given a non-zero positive integer n, return a list of integers of size n containing (in correct order) the first n numbers in the fibonacci series.
          Example: fibonacciSeries(5) returns a list containing the numbers 1, 1, 2, 3, and 5.

public List<Integer> fibonacciSeries(Integer n) {
  List<Integer> result = new List<Integer>();

    // Handle the base case when n is 1 or 2
    if (n >= 1) {
        result.add(1);
    }
    if (n >= 2) {
        result.add(1);
    }

    // Generate the Fibonacci series for n > 2
    for (Integer i = 2; i < n; i++) {
        int nextFibonacci = result[i - 1] + result[i - 2];
        result.add(nextFibonacci);
    }

    return result;
}


67. Org Names
Use case: Some Salesforce orgs (Trailhead playground orgs, for example) are given random names that include a combination of an adjective and an animal as a prefix. For instance, cunning-impala, curious-raccoon, and brave-hawk are possible prefixes for names for such orgs.
          Implement the method generateOrgNames that takes as input two lists of strings adjectives and animals, and returns a list of strings containing all org name prefixes that can be formed by combining the adjectives and animals. Assume that the input lists will never be empty

public List<String> orgNames(List<String> adjectives, List<String> animals) {
    List<String> orgNames = new List<String>();
    
    for (String adjective : adjectives) {
        for (String animal : animals) {
            String orgName = adjective + '-' + animal;
            orgNames.add(orgName);
        }
    }
    
    return orgNames;
}


68. Sorted List
Use case: A list is considered to be sorted ascending when no element in the list is smaller than the preceding element if one is present. Similarly, a list is considered sorted descending if no element in the list is larger than the preceding element if any.
	  Implement the method isSorted that takes as input a list of integers numbers, returns true if the list is sorted in any direction (acsending or descending), and returns false otherwise.
          Example: isSorted(new List<Integer> {5, 2, 0, -1}) evaluates to true because the input list is sorted descending.

public boolean isSorted(List<Integer> numbers) {
    Boolean ascending = true;
    Boolean descending = true;

    for (Integer i = 1; i < numbers.size(); i++) {
        if (numbers[i] > numbers[i - 1]) {
            descending = false;
        } else if (numbers[i] < numbers[i - 1]) {
            ascending = false;
        }
    }

    return ascending || descending;
}


69. Second Largest Element
Use case: Given an list of Integers numbers, return the second largest integer in the list. Assume that the input list will always contain at least two distinct integers.
	  Example: secondLargest(new List {5, 2, 8, 4, 8, 1}) evaluates to 5 because 5 is the second largest Integer in the array, with 8 being the largest integer.
	  Note: While not necessary to solving this problem, it may be be helpful to know the smallest possible Integer: -2,147,483,648. However, you cannot set an integer directly to this value because of a bug in Apex, but you can do the following:
	  Integer num = -2147483647 - 1;

public Integer secondLargest(List<Integer> numbers) {
     numbers.sort();    
     for(Integer i = numbers.size()-1; i>=0;i--){        
         if(numbers[i] != numbers[numbers.size()-1]){            
             return numbers[i];        
         }    
     }    
     return null;
}


70. Union
Use case: A union between two sets A and B is a set that contains all elements from A and B. For example, the unions of sets {1, 5, 10} and {1, 3, 5} is {1, 3, 5, 10}.
	  Implement the method setUnion that takes as input two sets of integers set1 and set2 and returns the union of the two sets. The method should not modify the original sets.
	  Given the following test code:
	  Set<Integer> set1 = new Set<Integer> {1, 2};
	  Set<Integer> set2 = new Set<Integer> {4, 5};
	  Set<Integer> set3 = setUnion(set1, set2);
	  The set set3 contains the numbers 1, 2, 4, and 5.

public Set<Integer> setUnion(Set<Integer> set1, Set<Integer> set2) {
    Set<Integer> set3 = new Set<Integer>();
    
    for(Integer i : set1){
        set3.add(i);
    }
    
    for(Integer i : set2){
        set3.add(i);
    }

    return set3;
}


71. Intersection
Use case: An intersection between two sets A and B is a set that contains all elements present in both A and B. For example, the intersection of sets {1, 5, 10} and {1, 3, 5} is {1, 5}, since 1 and 5 are the only two elements present in both sets.
	  Implement the method setIntersection that takes as input two sets of integers set1 and set2 and returns the intersection of the two sets. The method should not modify the original sets.
	  Given the following test code:
	
	  Set<Integer> set1 = new Set<Integer> {1, 2, 3};
	  Set<Integer> set2 = new Set<Integer> {4, 3, 2};
	  Set<Integer> set3 = setUnion(set1, set2);
	  The set set3 contains the numbers 2 and 3.









