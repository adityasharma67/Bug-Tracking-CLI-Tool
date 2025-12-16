# Bug Tracking CLI Application

A robust Command Line Interface (CLI) tool for managing software bugs, built with Java and Maven.

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Maven](https://img.shields.io/badge/apache_maven-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)

## Features

- **Add Bugs**: Quickly log new issues with titles.
- **List Bugs**: View all bugs with their unique ID and status (OPEN/CLOSED).
- **Close Bugs**: Mark issues as resolved by their ID.
- **Data Persistence**: Bugs are stored in memory for the active session.

## Getting Started

### Prerequisites

- **Java JDK 8 or higher** (JDK 17 recommended)
- **Maven** (Optional, for building manually)

### Installation & Run

1.  **Clone the repository**
    ```bash
    git clone https://github.com/adityasharma67/Bug-Tracking-CLI-Tool.git
    cd Bug-Tracking-CLI-Tool
    ```

2.  **Run with Auto-Script (Windows PowerShell)**
    This script automatically finds your JDK, builds the project, and runs it.
    ```powershell
    .\run_project.ps1
    ```

### Manual Build

If you prefer running commands manually:

```bash
mvn clean install
java -jar target/bugtracker-1.0-SNAPSHOT.jar
```

## Usage

```text
--- Bug Tracker ---
1. Add Bug
2. List Bugs
3. Close Bug
4. Exit
Choose an option:
```

## Project Structure

```
src/main/java/com/bugtracker/
├── App.java         # Main CLI Entry Point
├── Bug.java         # Data Model
└── BugTracker.java  # Business Logic
```
