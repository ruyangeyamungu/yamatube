package ATM;
import java.util.Scanner;


enum stats {
	Try_Again,
}
public class UserAccount {
	Scanner scanner = new Scanner(System.in);
	int cardNo;
	int pCode;
	
	public void signUp() {
	try {
		System.out.println("***CREATE AN ATM ACCOUNT****");
		System.out.print("enter a your bank card number: ");
		CardNoSigningUp();
		pCodeSignUp();
		
		/* PCARD AND PCODE BE SUBMITTED TO DATABASE FOR SOTRAGE*/
		
	}catch(Exception e) {
		//e.printStackTrace();
		System.out.println("wrong input");
	  }
	}
	
	public void signIn() {
	    System.out.println("***SIGN IN******");	
	    System.out.print("enter your card number: ");
	    cardNo = scanner.nextInt();
	    System.out.print("enter your passcode: ");
	    pCode = scanner.nextInt();
	    if(cardNo != 0 && pCode != 0) {
	           /*DISPLAYING THE ATM MENU FUNCTION*/	
	    OptionalMenus mainMenu = new OptionalMenus();
	    mainMenu.mainMenus();
	    	//System.out.print(true);
	    }else {
	    	System.out.checkError();
	    }
	    
	}

	private void pCodeSignUp() {
		System.out.print("enter a passcord: " );
		pCode = scanner.nextInt();
		System.out.print("confrim your passcode: ");
		int pCordConfrim = scanner.nextInt();
		if(pCode == pCordConfrim) {
			pCodeSigningUp();
		}else {
			System.out.println("passcord dont match, ");
			System.out.println(stats.Try_Again);
			pCodeSignUp();		
		}
	}
	
	private int CardNoSigningUp() {
		cardNo = scanner.nextInt();
		return cardNo;
	}
	
	private int pCodeSigningUp() {
       return pCode;
	}
	
     public static void main(String args []) {
    	 UserAccount x = new UserAccount();
    	// x.signUp();
    	 x.signIn();
     }
}
