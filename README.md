# JavaPOS – Web-based Point of Sale System 💻🧾

A modern, lightweight, web-based POS (Point of Sale) system built using **Java Servlets**, **JSP**, and **MySQL**. Designed for restaurants or cafes with multi-role user support: admin, cashier, and waiter.

---

## 🚀 Features

- ✅ User Login System (Admin, Cashier, Waiter)
- ✅ Order and Cart Management
- ✅ Menu Items and Categories
- ✅ Payments and Order Tracking
- ✅ Dynamic Role-based Dashboards
- ✅ Clean UI with HTML, CSS, and Bootstrap (optional)

---

## 📂 Project Structure

```
JavaPOS/
├── src/
│   └── main/
│       ├── java/com/javapos/...     # Java code (controller, dao, database)
│       ├── resources/               # Resource files (if any)
│       └── webapp/                  # JSP pages, css, WEB-INF
│           ├── login.jsp
│           ├── dashboard.jsp
│           ├── css/
│           └── WEB-INF/web.xml
├── pom.xml                         # Maven project file
└── README.md                       # This file
```

---


## 🗃️ Database Setup

All database creation and sample data files are located in the [`/db`](./db) folder.

Please follow the guide in [`db/README.md`](./db/README.md) to:

- Create the `POS` database
- Import table structure (`init.sql`)
- Add test data (`seed.sql`)
- Get default login credentials


## 🧰 Technologies Used

- Java 8+
- Maven
- Servlets & JSP
- MySQL
- Apache Tomcat 8.5+
- Git/GitHub for collaboration
- (Optional: Bootstrap for frontend styling)

---

## ⚙️ How to Run (Local Setup)

### 1. Clone the repo

```bash
git clone https://github.com/catalansubanta/JavaPOS.git
cd JavaPOS
```

### 2. Import into Eclipse

- Open **Eclipse**
- Go to **File > Import > Maven > Existing Maven Project**
- Select the root project directory
- Finish and let Maven build

### 3. Update Maven Dependencies

- Right-click the project → Maven → Update Project (Alt + F5)
- Check "Force update of snapshots/releases"

### 4. Run on Tomcat Server

- Open **Servers** view
- Right-click → New → Server → Apache Tomcat 8.5+
- Add the project to server
- Start the server

### 5. Set up MySQL Database

- Ensure MySQL is running (XAMPP or similar)
- Import provided `init.sql` and `seed.sql`
- Update DB credentials in `DatabaseConnection.java`

### 6. Visit the App

```bash
http://localhost:8080/JavaPOS
```

---

## 👥 Team Members

- Subanta Poudel  
- Shree Ram Shrestha  
- Parshant GC  
- Saksham Thakuri  
- Ritik Kunwar

---

## 👥 Collaborator Access

To allow team members to contribute and push code:

1. Go to your repo on GitHub: `https://github.com/catalansubanta/JavaPOS`
2. Click the **Settings** tab → **Collaborators & teams**
3. Click **"Invite a collaborator"**
4. Type their GitHub username and click **Add**
5. They’ll receive an invite to accept

Once accepted, teammates can clone, create branches, push changes:

```bash
git clone https://github.com/catalansubanta/JavaPOS.git
cd JavaPOS

# Create a new branch
git checkout -b feature/dashboard

# Make changes
# Then push

git add .
git commit -m "Working on dashboard"
git push origin feature/dashboard
```

✅ Make sure they’re added with **write access**, not just read.

---

## 📌 Notes

- Ensure Dynamic Web Module 3.1 and Java 8+ are enabled under Project Facets
- Server runtime libraries must be added via Project → Properties → Java Build Path
- If `target/`, `.classpath`, or `.settings/` folders are committed, add `.gitignore`

```
/target/
.classpath
.project
.settings/
```

---

## 💬 Troubleshooting

### 404 Not Found
- Check servlet mapping (in `web.xml` or `@WebServlet`) matches the URL you're using

### Class Not Found
- Ensure Maven dependencies are installed
- Check Tomcat runtime is added

### Login not working?
- Make sure DB has test users (admin, cashier, waiter)
- Use the right username/password





###

#to clone the Repository
git clone https://github.com/catalansubanta/JavaPOS.git
cd JavaPOS

# Then create a new branch before working on a feature
git checkout - b feature/your-feature-name
(git checkout -b feature/dashboard)

# To add and commit 
git add .
git commit -m "Add feature: dashboard layout"

# Push to github
git push origin feature/dashboard



###### Do not push to main unless you're sure!
## always pull the latest changes before working
git pull origin main
