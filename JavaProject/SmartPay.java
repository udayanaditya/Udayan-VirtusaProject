package JavaProject;
import java.util.Scanner;

// Interface Billable
interface Billable{
    double calculateTotal(int itemUnits);
}

// Class implementing interface Billable
class BillGenerator implements Billable{
    private double taxAmount = 0;

    // Method to calculate the tax
    public double calculateTotal(int itemUnits){
        double calculatedTotal=0;

        if(itemUnits<=100){
            calculatedTotal= itemUnits * 1.0;
        }
        else if(itemUnits<=300){
            calculatedTotal= (100 * 1.0) + (itemUnits-100) * 2.0;
        }
        else{
            calculatedTotal= (100 * 1.0) + 200 * 2.0 + (itemUnits-300) * 5.0;
        }
        taxAmount = calculatedTotal * 0.05;
        return calculatedTotal + taxAmount;
    }
    public double getTaxAmount(){
        return taxAmount;
    }
}

// Main class
public class SmartPay {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        while (true) {

            System.out.print("\nEnter Customer Name (or type Exit): ");
            String name = sc.nextLine();

            if (name.equalsIgnoreCase("Exit")) {
                System.out.println("Exiting SmartPay System");
                break;
            }

            System.out.print("Enter Previous Meter Reading: ");
            int prev = sc.nextInt();

            System.out.print("Enter Current Meter Reading: ");
            int curr = sc.nextInt();
            sc.nextLine();

            // Input Validation
            if (curr < prev) {
                System.out.println("Error: Current reading cannot be less than previous reading.");
                continue;
            }

            int units = curr-prev;

            BillGenerator bill = new BillGenerator();
            double finalAmount = bill.calculateTotal(units);

            // Digital Receipt
            System.out.println("\n RECEIPT: ");
            System.out.println("Customer Name   : " + name);
            System.out.println("Units Consumed  : " + units);
            System.out.printf("Tax Amount (5%%): %.2f\n", bill.getTaxAmount());
            System.out.printf("Final Total     : %.2f\n", finalAmount);
        }
        sc.close();
    }
}