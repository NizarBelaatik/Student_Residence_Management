# Student Residence Management



## Overview

The **Student Residence Management** system is a web-based application designed to simplify the management of student residences. The application allows administrators to manage rooms, residents, payments, and maintenance requests efficiently. Built with **Jakarta EE** (formerly Java EE), this system is hosted on **Apache Tomcat** and uses **MySQL** or **MariaDB** for database management.

---

## Features

- **Room Management:** Create, update, and manage room details, including availability and equipment.
- **Resident Management:** Register and update resident profiles, track payment history, and manage room assignments.
- **Payment Tracking:** Facilitate payments, track due amounts, and send notifications for overdue payments.
- **Maintenance Requests:** Allow residents to submit maintenance issues, and track resolution progress.
- **User Authentication:** Secure login system with roles for Admin, Residents, and Technicians.
- **Real-time Notifications:** Email and in-app notifications for key events (e.g., payment reminders, maintenance updates).
- **Statistical Reports:** Generate reports for occupancy rates, payment status, and maintenance history.

---

## Technologies Used

- **Jakarta EE:** A collection of specifications extending Java SE, providing enterprise-level features like dependency injection, web services, and messaging.
- **Maven:** A build automation tool for dependency management and project building.
- **Apache Tomcat:** A widely used web server and servlet container to run Jakarta EE applications.
- **MySQL / MariaDB:** Relational database management systems for storing user, room, payment, and maintenance data.
- **HTML, CSS, JavaScript (AJAX):** Frontend technologies for building a dynamic and responsive user interface.
- **Bootstrap:** A front-end framework to create responsive and user-friendly web interfaces.
- **bcrypt:** Secure password hashing for user authentication.

---

## Prerequisites

To run this application locally, ensure you have the following software installed:

- **Java 8** or higher
- **Maven 3.x** or higher
- **Apache Tomcat 9.x** or higher
- **MySQL** or **MariaDB** server

---

## Getting Started

Follow the steps below to set up and run the project locally.

### 1. Clone the Repository

Start by cloning the repository to your local machine:

```bash
git clone https://github.com/NizarBelaatik/Student_Residence_Management.git
cd Student_Residence_Management
```

### 2. Set Up the Database

You need to set up the MySQL or MariaDB database. The project includes an SQL dump to create the necessary tables and populate them with initial data.

#### Steps to Import the Database:

1. **Install MySQL/MariaDB:**  
   If not already installed, download and install MySQL or MariaDB from their respective websites:
   - [MySQL](https://dev.mysql.com/downloads/)
   - [MariaDB](https://mariadb.org/download/)

2. **Create the Database:**
   Open the terminal or command prompt and log in to your MySQL/MariaDB server:

   ```bash
   mysql -u root -p
   ```

   Once logged in, create a new database:

   ```sql
   CREATE DATABASE srm_db;
   ```

3. **Import the SQL Dump:**
   Import the `srm_db.sql` dump file to create the tables and populate initial data:

   ```bash
   mysql -u root -p srm_db < /path/to/srm_db.sql
   ```

   Replace `/path/to/srm_db.sql` with the actual location of the SQL dump file.

4. **Verify the Import:**
   After importing, log into MySQL again and check the tables:

   ```bash
   mysql -u root -p
   USE srm_db;
   SHOW TABLES;
   ```

   You should see the relevant tables, such as `email_verification`, `maintenance_requests`, etc.

### 3. Install Dependencies

Use Maven to install the project dependencies:

```bash
mvn clean install
```

### 4. Set Up Apache Tomcat

If you don’t have **Apache Tomcat** installed, download it from [Tomcat Downloads](https://tomcat.apache.org/download-90.cgi) and install it.

Once installed, deploy the application by copying the generated `.war` file into the `webapps` directory of your Tomcat installation.

### 5. Start Apache Tomcat

Navigate to your Tomcat `bin` directory and start the server:

```bash
cd /path/to/tomcat/bin
./startup.sh    # Linux/macOS
startup.bat     # Windows
```

### 6. Access the Application

Once Tomcat has started, open your browser and go to:

```
http://localhost:8080/Student_Residence_Management
```

You should now see the Student Residence Management application running locally.

---

## Configuration

Some settings might need to be configured for your local environment, such as:

- **Database Connection:** Ensure that the application is correctly connected to your MySQL/MariaDB database. Configuration files may need to be updated with your database credentials (e.g., username, password, database name).
- **Tomcat Configuration:** Ensure that your Tomcat server has enough memory allocated to run the application smoothly.

---

## Running Tests

To run unit tests and verify that everything is working correctly, use Maven:

```bash
mvn test
```

This will run all the defined unit tests and provide feedback on the project’s health.

---

## Troubleshooting

1. **Database Connection Issues:**  
   Double-check your MySQL/MariaDB credentials and ensure the database is running.
   
2. **Tomcat Not Starting:**  
   Make sure the `PORT` is not being used by another application. You can change the default port in Tomcat's `conf/server.xml` file.

3. **Missing Dependencies:**  
   If you encounter missing dependencies, run `mvn clean install` to rebuild the project and download any required libraries.

---

## Contributing

If you’d like to contribute to this project:

1. Fork the repository
2. Create a new feature branch (`git checkout -b feature/feature-name`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/feature-name`)
5. Create a new Pull Request



