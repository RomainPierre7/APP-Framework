# Apache_PHP_PostgreSQL_Framework

This framework enables the easy local deployment of a PHP website under Apache, connected to a PostgreSQL database server. In just a few seconds, everything is set up, leaving only the development tasks. A local server update script and an architectural skeleton are provided to streamline the development process.


## ✨ Key Features:

* **Automated Local Server** : Set up your PHP development environment effortlessly with an integrated Apache server and PostgreSQL database.
* **Effortless Initialization** : Start coding within seconds, no tedious server configurations needed.
* **Architecture Skeleton** : Organize your projects efficiently with a clear and structured 'src' directory.
* **Database Interaction** : Connect seamlessly to PostgreSQL databases with pre-configured files.
* **Test Data Management** : Easily load or clear test data from the database via the web interface.
* **Update and Deployment** : Push your latest changes quickly using the ```push_server.sh``` script.

## ⚙️ Procedure

### Clone the template

Use the **USE THIS TEMPLATE** button on the github repository or clone it.

```bash
git clone https://github.com/RomainPierre7/Apache_PHP_PostgreSQL_Framework.git
```

### Run the configuration script

> Run the script as root

```bash
sudo ./config/create_local.sh
```

Enter the application name when prompted by the script. **NOTE:** The app's name will also be the name of the database and its user.

* The script checks and installs the correct Apache, PHP, and PostgreSQL packages.
* It creates the corresponding database in PostgreSQL.
* It configures the Apache server and updates the name resolution in /etc/hosts.
* It provides the link where you can find your site.

> Now you just have to develop ! Use ```./push_server.sh ``` to update your latest version on the site and quickly preview your development.

## 📁 Skeleton Details

The source folder **src** is divided into several parts:

* **admin_databse**: Groups the execution scenarios of the database to test the application (load test data, simulate actions, clear the database). (See at the bottom of the index.php page).
* **app**: This is where you should place your PHP/HTML files related to the functioning of the application (typically web pages and processing files).
* **assets**: Groups all media (photos, videos, music, etc.) for your application.
* **connect_database**: Contains the database connection files. These files link the front end to the back end. Include the connection file at the beginning of each page requiring database access. (See index.php).
* **css**: Groups all CSS style sheets.
* **sql**: Contains SQL scripts for creating, deleting databases, inserting test data, updating test data, etc. (See the headers of the scripts).
* **templates**: Contains PHP/HTML files that are repeated multiple times in the code (typically the header and the footer).
* **user**: This section should contain PHP files related to managing site users (login, logout, etc).
* **index.php**: This is the landing page of the site.