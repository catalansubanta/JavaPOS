package com.javapos.model;

public class TableNo {
    private int tableId;
    private int tableNumber;
    private String tableStatus;

    public TableNo() {}

    public TableNo(int tableId, int tableNumber, String tableStatus) {
        this.tableId = tableId;
        this.tableNumber = tableNumber;
        this.tableStatus = tableStatus;
    }

    // Getters and Setters
    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }

    public int getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(int tableNumber) {
        this.tableNumber = tableNumber;
    }

    public String getTableStatus() {
        return tableStatus;
    }

    public void setTableStatus(String tableStatus) {
        this.tableStatus = tableStatus;
    }
}
