# Student Residence Management

## Description
A brief description of your project, what it does, and its purpose. Include any key features or technologies used.

This project is built using Jakarta EE (formerly Java EE), Maven, and deployed on Apache Tomcat.

## Technologies Used
- **Jakarta EE** - A set of specifications that extend Java SE with specifications for enterprise features such as dependency injection, web services, and messaging.
- **Maven** - A build automation tool used for managing project dependencies and building the project.
- **Apache Tomcat** - A web server and servlet container used to run the Jakarta EE application.

## Prerequisites
Before you begin, make sure you have met the following requirements:
- Java 8 or higher
- Maven 3.x or higher
- Apache Tomcat 9.x or higher
- **MySQL** or **MariaDB** server

## Getting Started

### 1. Clone the repository
To get a copy of this project running locally, follow these steps:

```bash
git clone https://github.com/NizarBelaatik/Student_Residence_Management.git
cd yourproject
```

### 2. Set Up the Database

To set up the database for the application, you need to import the provided SQL dump into your MySQL or MariaDB server.

#### Steps to Import the Database:

1. **Ensure MySQL/MariaDB is Installed:**
   If you don't have MySQL or MariaDB installed, you can download and install it from the official website:
   - [MySQL](https://dev.mysql.com/downloads/)
   - [MariaDB](https://mariadb.org/download/)

2. **Create a New Database:**
   Open your terminal or command prompt and log in to MySQL/MariaDB:
   ```bash
   mysql -u root -p
   ```

   Once logged in, create a new database (replace `srm_db` with your desired database name):
   ```sql
   CREATE DATABASE srm_db;
   ```

3. **Import the SQL Dump:**
   Ensure that you have the `srm_db.sql` file located on your local system. Then, use the following command to import the database structure and data:
   ```bash
   mysql -u root -p srm_db < /path/to/srm_db.sql
   ```

   Make sure to replace `//srm_db.sql` with the actual file path of the `srm_db.sql` dump file.

4. **Verify the Import:**
   After the import is complete, you can verify that the tables and data were imported successfully by logging into MySQL again:
   ```bash
   mysql -u root -p
   USE srm_db;
   SHOW TABLES;
   ```

   You should see the tables listed (e.g., `email_verification`, `maintenance_requests`, etc.).

### 3. Install Dependencies
Ensure that all Maven dependencies are installed:

```bash
mvn clean install
```

### 4. Set Up Apache Tomcat
Make sure Apache Tomcat is installed on your system. You can download and install Tomcat from [https://tomcat.apache.org/download-90.cgi](https://tomcat.apache.org/download-90.cgi).

Once installed, deploy the project by copying the WAR file into the `webapps` directory of your Tomcat installation.


Adjust the settings according to your environment.

### 5. Start Tomcat
Navigate to your Tomcat installation directory and start the server:

```bash
cd /path/to/tomcat/bin
./startup.sh  # On Linux/macOS
startup.bat   # On Windows
```

### 6. Access the Application
Once Tomcat is running, you can access the application by navigating to:

```
http://localhost:8080/yourproject
```
