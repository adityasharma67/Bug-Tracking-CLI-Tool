package com.bugtracker;

import java.util.ArrayList;
import java.util.List;

public class BugTracker {
    private List<Bug> bugs;
    private int nextId;

    public BugTracker() {
        this.bugs = new ArrayList<>();
        this.nextId = 1;
    }

    public void addBug(String title) {
        Bug bug = new Bug(nextId++, title);
        bugs.add(bug);
        System.out.println("Bug added: " + bug);
    }

    public void listBugs() {
        if (bugs.isEmpty()) {
            System.out.println("No bugs found.");
        } else {
            for (Bug bug : bugs) {
                System.out.println(bug);
            }
        }
    }

    public void closeBug(int id) {
        for (Bug bug : bugs) {
            if (bug.getId() == id) {
                bug.close();
                System.out.println("Bug closed: " + bug);
                return;
            }
        }
        System.out.println("Bug with ID " + id + " not found.");
    }
}
