package com.bugtracker;

import java.util.Scanner;

public class App {
    public static void main(String[] args) {
        BugTracker tracker = new BugTracker();
        Scanner scanner = new Scanner(System.in);
        boolean running = true;

        while (running) {
            System.out.println("\n--- Bug Tracker ---");
            System.out.println("1. Add Bug");
            System.out.println("2. List Bugs");
            System.out.println("3. Close Bug");
            System.out.println("4. Exit");
            System.out.print("Choose an option: ");

            String input = scanner.nextLine();

            switch (input) {
                case "1":
                    System.out.print("Enter bug title: ");
                    String title = scanner.nextLine();
                    tracker.addBug(title);
                    break;
                case "2":
                    tracker.listBugs();
                    break;
                case "3":
                    System.out.print("Enter bug ID to close: ");
                    try {
                        int id = Integer.parseInt(scanner.nextLine());
                        tracker.closeBug(id);
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid ID format.");
                    }
                    break;
                case "4":
                    running = false;
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid option. Please try again.");
            }
        }
        scanner.close();
    }
}
