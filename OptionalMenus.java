package ATM;
import java.util.Scanner;
public class OptionalMenus  {
	Scanner scanner = new Scanner(System.in);
	
	/*CHECKING ACCOUNT MENUS*/
	public void checkingAccountMenus() {
		int x = 0;
		while (x==0) {
		CheckingAccount checkingObj = new CheckingAccount();
		System.out.println("1. DEPOSIT");
		System.out.println("2. WITHDRAW");
		System.out.println("3. CHECK BALANCE");
		System.out.println("4. EXIT");
		int choice = scanner.nextInt();
		switch(choice) {
		case 1:
			checkingObj.despositCheckingbalance();
			break;
		case 2:
			checkingObj.withDrawCheckingBalance();
			break;
		case 3:
			checkingObj.viewcheckingbalnce();
		break;
		case 4:
			checkingObj.exit();
		}
		}
	}
	
	/*SAVING ACCOUNT MENUS*/
	public void savingAccountMenus() {
		SavingAccount savingObj = new SavingAccount();
		System.out.println("1. DEPOSIT");
		System.out.println("2. WITHDRAW");
		System.out.println("3. CHECK BALANCE");
		System.out.println("4. EXIT");
		int savingchoice = scanner.nextInt();
		switch(savingchoice) {
			case 1:
				savingObj.despositSavingbalance();
				break;
			case 2:
				savingObj.withDrawSavingBalance();
				break;
			case 3:
				savingObj.viewSavingbalnce();
				break;
			case 4:
				savingObj.exit();
				break;
	}
}
	
  /*MAIN MUNES*/
	public void mainMenus() {
		System.out.println("1. CHEKING ACCOUNT");
		System.out.println("2. SAVING ACCOUNT");
		try {
		int select = scanner.nextInt();
			switch(select) {
			case 1:
				checkingAccountMenus();
				break;
			case 2:
				savingAccountMenus();
				break;
			}
		}catch(Exception e) {
			System.out.print(status.failed);
		}
	}
	
//	public static void main(String args []) {
//	OptionalMenus x = new OptionalMenus();
//		x.mainMenus();
//	}
//        
}






