#### JavaPOS – Web-based Point of Sale System 💻🧾
A modern, lightweight web-based POS (Point of Sale) system built using Java Servlets, JSP, and MySQL. It supports multi-role users: Admin, Cashier, and Waiter — perfect for restaurants or cafes.

## 🚀 Features
✅ User Login System (Admin, Cashier, Waiter)

✅ Order and Cart Management

✅ Menu Items and Categories

✅ Payments and Order Tracking

✅ Role-based Dashboards

✅ Clean UI using HTML, CSS (Bootstrap optional)

## 📁 Project Structure

JavaPOS/
├── src/
│   └── main/
│       ├── java/com/javapos/...     # Java code
│       ├── resources/               # Config files (if any)
│       └── webapp/                  # JSP, CSS, WEB-INF
│           ├── login.jsp
│           ├── dashboard.jsp
│           ├── css/
│           └── WEB-INF/web.xml
├── db/
│   ├── init.sql                     # Table structure
│   └── seed.sql                     # Sample data
├── pom.xml                          # Maven build file
└── README.md                        # This file
## 🗃️ Database Setup
The database files are in the /db folder.

To set up:

Open phpMyAdmin or MySQL Workbench.

Create a database called POS.

Import init.sql to create tables.

Import seed.sql to add sample data.

Default users:


Role	Username	Password
Admin	admin01	admin123
Cashier	cashier01	cash123
Waiter	waiter01	wait123
## 💻 How to Clone and Import Project in Eclipse
✅ Step 1: Clone the GitHub Repo

cd %USERPROFILE%\eclipse-workspace
git clone https://github.com/catalansubanta/JavaPOS.git
🔐 If it asks for GitHub login, use your username and personal access token (PAT) instead of your password.

## ✅ Step 2: Import into Eclipse
Open Eclipse.

Go to File > Import.

Select Maven > Existing Maven Projects → click Next.

Click Browse and select the JavaPOS folder.

Make sure pom.xml is detected → click Finish.

## ✅ Step 3: Update Maven Dependencies
Right-click the project.

Go to Maven > Update Project (Alt + F5).

Check "Force Update of Snapshots/Releases" → click OK.

## ✅ Step 4: Set Up Tomcat Server (if not already set)
Go to Window > Show View > Servers.

In the Servers tab → right-click → New > Server.

Select Apache > Tomcat 8.5 and set the Tomcat installation folder.

Click Finish.

## ✅ Step 5: Add Project to Tomcat Server
In the Servers tab, right-click your server → Add and Remove.

Move your JavaPOS project from left to right.

Click Finish → Start the server.

## ✅ Step 6: Add Server Runtime to Build Path (Important for fixing servlet errors)
Right-click your project → Properties.

Go to Java Build Path > Libraries tab.

Click Add Library > Server Runtime > Next.

Select your Tomcat server → Finish → Apply and Close.

## 🌐 Run the App
Once the server is running:


http://localhost:8080/JavaPOS
### 👥 Team Members
Subanta Poudel

Shree Ram Shrestha

Parshant GC

Saksham Thakuri

Ritik Kunwar

## 🔁 Git Workflow – Pull / Push
# ✅ To Pull or Clone the Repo

cd %USERPROFILE%\eclipse-workspace
git clone https://github.com/catalansubanta/JavaPOS.git
Then go to Eclipse and:

File > Import > Maven > Existing Maven Projects
## ✅ To Push Changes to GitHub
# Create a new branch before working:


git checkout -b feature/your-feature-name
# Add and commit your changes:

git add .
git commit -m "Add feature: dashboard layout"
# Push to GitHub:

git push origin feature/your-feature-name
## 🔐 Collaborator Access
To give teammates access:

Go to your repo on GitHub.

Click Settings > Collaborators.

Add their GitHub username and click Invite.

## 🧠 Tips
Always use git pull to sync before pushing.

Avoid pushing directly to main.

Use .gitignore to avoid unnecessary files:

bash
Copy
Edit
/target/
.classpath
.project
.settings/
