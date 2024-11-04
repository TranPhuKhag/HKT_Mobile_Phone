/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.AccountDAO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Asus
 */
public class AccountController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();

        if (action.equals("edit")) {                              // EDIT 
            Integer id = Integer.parseInt(request.getParameter("id"));
            UserDTO user = null;
            if (id != null) {
                user = dao.load(id);
            }

            request.setAttribute("object", user);
            request.setAttribute("nextaction", "update");
            RequestDispatcher rd = request.getRequestDispatcher("changePassword.jsp");
            rd.forward(request, response);

        } else if (action.equals("update")) {                            //UPDATE
            Integer id = Integer.parseInt(request.getParameter("id"));
            String password = request.getParameter("password");
            UserDTO user = dao.load(id);

            user.setPassword(password);
            dao.update(user);
            request.setAttribute("object", user);
            RequestDispatcher rd = request.getRequestDispatcher("account.jsp");
            rd.forward(request, response);

        } else if (action.equals("details")) {                         // DETAIL
            Integer id = Integer.parseInt(request.getParameter("id"));
            UserDTO user = null;
            if (id != null) {
                user = dao.load(id);
            }
            if (user != null) {
                request.setAttribute("object", user);
                RequestDispatcher rd = request.getRequestDispatcher("account.jsp");
                rd.forward(request, response);
            }
            response.sendRedirect("homepage.jsp");

        }
        if (action.equals("editAccount")) {                              // EDIT 
            Integer id = Integer.parseInt(request.getParameter("id"));
            UserDTO user = null;
            if (id != null) {
                user = dao.load(id);
            }
            request.setAttribute("object", user);          
            RequestDispatcher rd = request.getRequestDispatcher("accountEdit.jsp");
            rd.forward(request, response);

        } else if (action.equals("updateAccount")) {                            //UPDATE
            Integer id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phonee = request.getParameter("phone");

            dao.update(id,name,email,phonee);
            UserDTO user= dao.load(id);
            request.setAttribute("object", user);
            RequestDispatcher rd = request.getRequestDispatcher("account.jsp");
            rd.forward(request, response);

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
