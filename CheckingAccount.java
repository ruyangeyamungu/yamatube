package ATM;
import java.util.Scanner;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CheckingAccount extends OptionalMenus {
  OptionalMenus optionalMenus = new OptionalMenus();
  Scanner scanner = new Scanner(System.in);
  double checkingAccountBalance;
  LocalDateTime time = LocalDateTime.now();
  DateTimeFormatter timeformat = DateTimeFormatter.ofPattern("H:mm:ss dd/MM/yyyy");
  String currentTime = timeformat.format(time);
 
  public void viewcheckingbalnce() {
	  System.out.println("your checking Account Balance is:  "+ checkingAccountBalance);
  }
  public void withDrawCheckingBalance()  {
	  System.out.println("enter the amount that you want to with draw: ");
   try {
	  double amount = scanner.nextDouble();
	  if (amount <checkingAccountBalance && amount < 0 ) {
	      calcWithDraw(amount);
	      System.out.println(status.proccessing);
	      
	      /*GIVING MONEY OUT BYE THE MASHINE*/
	      
	      System.out.println(status.successfull);
	      System.out.println("you have with draw: "+amount+"$" + " " + currentTime);
	  } else if(amount > checkingAccountBalance) {
		  System.out.println(" you dont have enouph money to withdraw " + amount);
	  }else {
		  System.out.print("invalid choice");
	  }
   }catch(Exception e) {
		  System.out.println("**invalid input**");
	  }
  }
  
  public void despositCheckingbalance() {
     int x =0;
	  while(x == 0) {
	  System.out.println("--enter the amount your want to deposit: ");
  try {
	  double amount = scanner.nextDouble();
	  if(amount > 0) {
		  System.out.println(status.proccessing);
		  
		  /*--------MASHINE SHOW SENCE FOR THE MONEY, AND SUBMIT IT------*/
		  
		   calcDepost(amount);
		   
		   System.out.println(status.successfull);
		   System.out.println("you have deposited: "+ amount+"$"+" at "+currentTime + "\n"+ "your totalbalance is "+checkingAccountBalance+"$");
	  }else if(amount < 0) {
		  System.out.println("you can not deposit " + amount +"\n"+ "must: amount > 0$");
	  }else {
		  System.out.println("invalid amount: ");
	  }
 }catch(Exception e) {
		  System.out.println("**invalid input**");
	 }
	  }
	  
  }
  
  public void exit() {
	  optionalMenus.mainMenus();
  }
  public double calcWithDraw( double amount) {
	   return checkingAccountBalance = checkingAccountBalance - amount;
  }
  public double calcDepost( double amount) {
	   return checkingAccountBalance = checkingAccountBalance + amount;
 }	
}
