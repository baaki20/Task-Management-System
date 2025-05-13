package com.novatech.controller;

import com.novatech.dao.TaskDAO;
import com.novatech.model.Status;
import com.novatech.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/tasks")
public class TaskController extends HttpServlet {

    private TaskDAO taskDAO;

    @Override
    public void init() throws ServletException {
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Task> tasks = taskDAO.getAllTasks();
            req.setAttribute("tasks", tasks);
            req.getRequestDispatcher("/task-list.jsp").forward(req, resp);

            String action = req.getParameter("action");

            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Task task = taskDAO.getTaskById(id);
                req.setAttribute("task", task);
                req.getRequestDispatcher("/edit-task.jsp").forward(req, resp);
                return;
            }

            if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                taskDAO.deleteTask(id);
                resp.sendRedirect("tasks");
                return;
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        LocalDate dueDate = LocalDate.parse(req.getParameter("dueDate"));
        Status status = Status.valueOf(req.getParameter("status"));

        Task task = new Task(title, description, dueDate, status);
        try {
            taskDAO.addTask(task);
            resp.sendRedirect("tasks");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
