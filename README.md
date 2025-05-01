# JavaPOS – Web-based Point of Sale System 💻🧾
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
│       ├── java/com/javapos/...     # Java servlets & classes
│           ├── controller/ login, logut, etc.
│           ├── dao/ UserDAO, ProductDAO
│           ├── model/ User.java. Product.java
│           ├── database/ DatabaseConnection.java
│           ├── filter/ AuthenticationFilter.java
│           └── utility/ Encryption
│       ├── resources/               # Config files (if any)
│       └── webapp/                  # JSP, CSS, WEB-INF
│           ├── js/ js for alerts
│           └── pages/              # all .jsp files
│               ├── auth/
│                   ├── login.jsp,
│                   └── register.jsp,
│               ├── dashboard.jsp
│                   └── admindashboard.jsp,
│               ├── Orders/
│               ├── Menu/
│               └── Common/             #header, footer
│           └── css/                    # css files for all pages
│           └── WEB-INF/web.xml
├── db/
│   ├── init.sql                     # Table structure
│   ├── seed.sql                     # Sample data
│   └── README.md                    # 
├── pom.xml                          # Maven build file
└── README.md                        # This file


##nTECHNOLOGIES Used

- Java 
- Maven
- Servlet & JSP
- MySQL
- Apache Tomcat 8.5
- git/github for collobaration
- 

## 🗃️ Database Setup

The database files are in the [`/db`](./db) folder.
please follow the guide in [`db/README.md`] (./db/README.md) to:

To set up:
1. Open phpMyAdmin or MySQL Workbench.
2. Create a database called `POS`.
3. Import `init.sql` to create tables.
4. Import `seed.sql` to add sample data.

Default users:


Role	Username	Password
Admin	admin01	admin123
Cashier	cashier01	cash123
Waiter	waiter01	wait123


## 💻 Setup in Eclipse

# ✅ Step 1: Clone the GitHub Repository
```bash 
# Windows (PowerShell or CMD)
cd %USERPROFILE%\eclipse‑workspace

# macOS/Linux
cd ~/eclipse‑workspace

git clone https://github.com/catalansubanta/JavaPOS.git
cd JavaPOS
```
🔐 If it asks for GitHub login, use your username and personal access token (PAT) instead of your password.

# ✅ Step 2: Import into Eclipse
File → Import…
Maven → Existing Maven Projects → Next
Browse to your cloned JavaPOS folder
Ensure pom.xml is detected → Finish

# ✅ Step 3: Update Maven Dependencies
Right‑click project → Maven → Update Project… (Alt + F5)
Check Force Update of Snapshots/Releases → OK

# ✅ Step 4: Configure Project Facets
Right‑click project → Properties → Project Facets
Enable Dynamic Web Module → set version 3.1
Enable Java → set version 1.8 or 11 (must match Tomcat)
Apply and Close
If you bump to Dynamic Web Module 4.0+, you’ll need Tomcat 9+.

# ✅ Step 5: Set Up Tomcat Server
Window → Show View → Servers
In Servers view → right‑click → New → Server
Choose Apache → Tomcat v8.5 Server, point to your install folder → Finish

# ✅ Step 6: Deploy Project to Tomcat
In Servers view → right‑click your Tomcat → Add and Remove…
Move JavaPOS from Available → Configured
Click Finish, then Start the server

# ✅ Step 7: Add Server Runtime to Build Path
Right‑click project → Properties → Java Build Path → Libraries
Click Add Library… → Server Runtime → Next
Select your Tomcat v8.5 → Finish → Apply and Close


## 🌐 Run the App
Once the server is running:


http://localhost:8080/JavaPOS


### 👥 Team Members
Subanta Poudel

Shree Ram Shrestha

Parshant GC

Saksham Thakuri

Ritik Kunwar


##

## 🔁 Git Workflow – Pull

# 1. Pull the latest changes

```bash
git pull origin main
```

# 2. Create a feature branch

```bash
git checkout -b feature/your-feature
```
# 3. To add & commit

```bash
git add .
git commit -m "Add: description of your change"
```

# 4. Push to remote

```bash
git push -u origin feature/your-feature
```
or 
```bash
git push origin feature/featurename
```



## Tips & Note: 
```
    Always use git pull to sync before pushing.
    Do not push to main unless you are sure!
    Use .gitignore to avoid unnecessary files: 
    
    git pull origin main

    ignore:
    
    /target/
    .classpath
    .project
    .settings/
```


## 🔄 Getting the Latest Updates

# ✅ From GitHub to Your Local PC

``` bash
cd path/to/your/JavaPOS
git branch              # see current branch
git checkout main       # switch if needed
git pull origin main    # fetch & merge latest
```

# 🔁 If You’re on a Feature Branch

```bash
git checkout feature/your-feature
git pull origin main    # merge updates from main
```

# 💡 Quick Reference

Task	                            Command
Clone the project first time	    git clone <url>
Update current branch with remote	git pull origin <branch>
Switch to another branch	        git checkout <branch>
Merge main into your branch	        git pull origin main


## Push changes to GitHub

# 1. In Terminal or Git Bash
```bash
cd path/to/JavaPOS
```

# 2. Check status
```bash
git status
```

# 3. Add changes
```bash
git add . 
```
 or add specific files (examples)
```bash
git add src/main/java/com/javapos/controller/RegisterController.java
```
may be something like this

# 4. Commit changes
```bash
git commit -m "Add register functionality with validation and filter integration"
```

# 5. Push to current branch
ex
```bash
git push origin feature/register
```
    or on main
```bash
git push origin main
```

# # # to Push to, need to have created a feature branch

## 🛠 Troubleshooting
# Missing servlet classes?
Ensure Tomcat runtime is on your Build Path (see Step 7) and your servlet dependency scope is provided.

# 404 Not Found
Verify web.xml URL‑patterns or your @WebServlet annotations.

# Tomcat won’t start
Check for port conflicts in server.xml and review the Eclipse console logs.

# Facet errors
Revisit Project Facets to confirm Dynamic Web Module and Java versions.


## 🤝 Contributing
1. Fork this repository
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

## Step-byStep guid for Git push if the push is not working

you need to be in the correct directory for this to work
always run command inside JavaPOS only

```bash
cd/path/JavaPOS

cd /Users/subantacatalan/eclipse-workspave/JavaPOS
```
# 1. Git Project
in the Eclipse terminal inside the project folder
```bash
    ls -a
```
to check if it's already a Git project
```bash 
    git init
```
to initialize Git inside the project

# 2. Connect to gitHub Repo
connecting local project to the GitHub repo
```bash
    git remore add origin https://github.com/catalansubanta/JavaPOS.git
```

# 3. Check branck
```bash
git branch
```

# 4. create new branch
```bash
git checkout -b feature/theNameofTheBranch
```

# 5. Stage all the files
```bash
git add .
```

# 6. Commit changes
```bash
git commit -m "whatever you changed or added"
```

# 7. Push
```bash
git push -u origin feature/feature-name
```


