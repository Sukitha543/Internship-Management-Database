# Internship-Management-Database

🚀 README: Internship Database Design
This repository contains the SQL script (Internship.sql) to create and populate a database named NextStep for managing internship data, including users, employers, internships, students, and applications. The database is designed for use with SQL Server and SQL Server Management Studio (SSMS).

Prerequisites
To run and test this SQL script, you need to have two main components installed on your system:

SQL Server Database Engine: A free edition like SQL Server Express is sufficient for this project.

SQL Server Management Studio (SSMS): This is the graphical tool used to connect to your SQL Server instance, execute the script, and view the results.

Installation Guide
Follow these steps to set up your environment:

1. Install SQL Server Express (Database Engine)
You need the SQL Server database engine to host the database. The Express edition is free and suitable for this use case.

Download: Go to the official Microsoft SQL Server downloads page and download the SQL Server Express edition.

Run the Installer: Run the downloaded executable (e.g., SQLServer2022-SSEI-Expr.exe).

Installation Type: Select the Basic installation for simplicity, or Custom if you need to specify features or a download location.

Follow Prompts: Accept the license terms and follow the on-screen instructions to complete the installation.

Note: The installer may also offer an option to install SSMS after the database engine is done—you can use that or follow the separate steps below.

2. Install SQL Server Management Studio (SSMS)
SSMS is the tool you will use to connect to your installed SQL Server and run the script.

Download: Download the latest version of SSMS from the Microsoft website.

Run the Installer: Open the downloaded SSMS installer file (e.g., SSMS-Setup-ENU.exe).

Install: Click Install and follow the prompts. You may be asked to allow the app to make changes to your device.

Restart: A restart of your machine may be recommended after the installation is complete.

How to Run the SQL Script
Once both SQL Server and SSMS are installed, follow these steps to set up the database:

Open SSMS: Launch SQL Server Management Studio from your Windows Start Menu.

Connect to Server: When the "Connect to Server" window appears:

Server name: Enter your server name. If you used the default instance during installation, this is typically your computer name, localhost, or simply .. If you used a named instance (e.g., SQLEXPRESS), the server name will be <YourComputerName>\<InstanceName> (e.g., .\SQLEXPRESS).

Authentication: Select Windows Authentication (the default for most local setups) or SQL Server Authentication if you configured a login during setup.

Click Connect.

Open the Script:

In SSMS, go to File > Open > File... and select the Internship.sql file.

Alternatively, open a new query window (File > New > Query with Current Connection) and copy the entire content of Internship.sql into the editor.

Execute the Script:

Ensure the connection is successful and you are viewing the query editor with the Internship.sql content.

Click the Execute button (or press F5).

The script will perform the following actions sequentially:

Create the NextStep database.

Create all necessary tables (User, Employer, Internship, etc.).

Insert initial data into all tables.

Execute a series of pre-written QUERY REPORTS to test and demonstrate data retrieval.

Run a simple TRANSACTION block to demonstrate updating an application status and shortlisting a student.

Review Results:

Check the Messages tab at the bottom of the query window to confirm that the commands executed successfully (e.g., "Command(s) completed successfully").

The results of all SELECT * FROM [TableName] and the final QUERY REPORTS will be displayed in the Results pane.

This will guide you through installing the necessary tools and executing the database setup script. The video [Install SQL Server Management Studio in 2 minutes] provides a quick walkthrough on how to connect to your SQL Server instance using SSMS.
