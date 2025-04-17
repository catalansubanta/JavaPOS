# 🗃️ JavaPOS Database Setup Guide

This folder contains SQL scripts required to initialize and seed the database for the JavaPOS project.

---

## 📦 Files Included

| File       | Purpose                            |
|------------|------------------------------------|
| `init.sql` | Creates all required tables        |
| `seed.sql` | Inserts sample data for testing    |

---

## 🛠️ Requirements

- ✅ MySQL (or MariaDB)
- ✅ Access to **phpMyAdmin**, MySQL Workbench, or terminal
- ✅ A database named: `POS`

---

## 🚀 Setup Instructions

### 1. Create the Database

Open MySQL or phpMyAdmin and run:

```sql
CREATE DATABASE POS;


phpMyAdmin → POS → Import → Choose File → init.sql







