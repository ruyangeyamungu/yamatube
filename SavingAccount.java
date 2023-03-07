package ATM;

import java.util.Scanner;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

enum status {
	successfull,
	proccessing,
	finished,
	failed,
	Invalid_Input,
}
public class SavingAccount extends OptionalMenus {
	OptionalMenus optionalMenus = new OptionalMenus();
	Scanner scanner = new Scanner(System.in);
	  double SavingAccountBalance = 100000;
	  LocalDateTime time =  LocalDateTime.now();
	  DateTimeFormatter timeformate = DateTimeFormatter.ofPattern("H:mm:ss dd/MM/yyyy");
	  String currentTime = time.format(timeformate);
	  
	  
	  public double viewSavingbalnce() {
		  System.out.println("your checking Account Balance is:  ");
		  return SavingAccountBalance;
	  }
	  public void withDrawSavingBalance()  {
		  System.out.println("enter the amount that you want to with draw: ");
	   try {
		  double amount = scanner.nextDouble();
		  if (amount < SavingAccountBalance && amount < 10000 ) {
		      calcWithDraw(amount);
		      System.out.println(status.proccessing);
		      
		      /*GIVING MONEY OUT BYE THE MASHINE*/
		      
		      System.out.println(status.successfull);
		      System.out.println("you have with draw: "+amount+"$" + " " + currentTime);
		  } else if(amount > SavingAccountBalance) {
			  System.out.println(" you dont have enouph money to withdraw " + amount);
		  }else {
			  System.out.print("invalid choice");
		  }
	   }catch(Exception e) {
			  System.out.println("**invalid input**");
		  }
	  }
	  
	  public void despositSavingbalance() {
		  System.out.println("--enter the amount your want to deposit: ");
	  try {
		  double amount = scanner.nextDouble();
		  if(amount > 0) {
			  System.out.println(status.proccessing);
			  
			  /*--------MASHINE SHOW SENCE FOR THE MONEY, AND SUBMIT IT------*/
			  
			   calcDepost(amount);
			   
			   System.out.println(status.successfull);
			   System.out.println("you have deposited: "+ amount+"$"+" at "+currentTime + "\n"+ "your totalbalance is "+SavingAccountBalance+"$");
		  }else if(amount < 0) {
			  System.out.println("you can not deposit " + amount +"\n"+ "must: amount > 0$");
		  }else {
			  System.out.println("invalid amount: ");
		  }
	 }catch(Exception e) {
			  System.out.println("**invalid input**");
		 }
		  
	  }
	  
	  public void exit() {
		  optionalMenus.mainMenus(); 
	  }
	  public double calcWithDraw( double amount) {
		   return SavingAccountBalance = SavingAccountBalance - amount;
	  }
	  public double calcDepost( double amount) {
		   return SavingAccountBalance = SavingAccountBalance + amount;
	 }
//	  public static void main(String args[]) {
//		SavingAccount x = new SavingAccount();
//		x.despositSavingbalance();
//	  }
	}