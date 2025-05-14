package com.novatech.dao;

import com.novatech.util.DBConnectionUtil;
import com.novatech.model.Status;
import com.novatech.model.Task;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    private static final String INSERT_SQL = "INSERT INTO tasks (title, description, due_date, status) VALUES (?, ?, ?, ?::task_status)";
    private static final String SELECT_ALL_SQL = "SELECT * FROM tasks ORDER BY due_date";
    private static final String SELECT_BY_ID_SQL = "SELECT * FROM tasks WHERE id = ?";
    private static final String UPDATE_SQL = "UPDATE tasks SET title = ?, description = ?, due_date = ?, status = ?::task_status WHERE id = ?";
    private static final String DELETE_SQL = "DELETE FROM tasks WHERE id = ?";

    public List<Task> getAllTasks() throws SQLException {
        List<Task> tasks = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_SQL);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                tasks.add(mapRowToTask(rs));
            }
        }
        return tasks;
    }

    public Task getTaskById(int id) throws SQLException {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BY_ID_SQL)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToTask(rs);
                }
            }
        }
        return null;
    }

    public void addTask(Task task) throws SQLException {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_SQL)) {
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setDate(3, Date.valueOf(task.getDueDate()));
            stmt.setString(4, task.getStatus().name());
            stmt.executeUpdate();
        }
    }

    public void updateTask(Task task) throws SQLException {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_SQL)) {
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setDate(3, Date.valueOf(task.getDueDate()));
            stmt.setString(4, task.getStatus().name());
            stmt.setInt(5, task.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteTask(int id) throws SQLException {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_SQL)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    private Task mapRowToTask(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String title = rs.getString("title");
        String desc = rs.getString("description");
        LocalDate dueDate = rs.getDate("due_date").toLocalDate();
        Status status = Status.valueOf(rs.getString("status"));
        LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();
        LocalDateTime updatedAt = rs.getTimestamp("updated_at").toLocalDateTime();
        return new Task(id, title, desc, dueDate, status, createdAt, updatedAt);
    }

    public List<Task> getTasksWithPagination(int limit, int offset) throws SQLException {
        String PAGINATED_SQL = "SELECT * FROM tasks ORDER BY due_date LIMIT ? OFFSET ?";
        List<Task> tasks = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(PAGINATED_SQL)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tasks.add(mapRowToTask(rs));
                }
            }
        }
        return tasks;
    }

    public int getTaskCount() throws SQLException {
        String COUNT_SQL = "SELECT COUNT(*) FROM tasks";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(COUNT_SQL);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
