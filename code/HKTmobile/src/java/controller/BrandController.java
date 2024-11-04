/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BrandDAO;
import dto.BrandDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class BrandController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        BrandDAO brandDAO = new BrandDAO();
        if (action == null || action.equals("list")) {
            List<BrandDTO> brandList = brandDAO.list();
            request.setAttribute("brandList", brandList);
            request.getRequestDispatcher("brandManagement.jsp").forward(request, response);
        } else if (action.equals("create")) {
            String name = request.getParameter("name");
            if (name != null && !name.equals("")) {
                brandDAO.insert(name);
            }
            response.sendRedirect("./Brand");
        } else if (action.equals("Delete")) {
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            String numberStr = request.getParameter("number");
            int number = 0;
            if (numberStr != null && !numberStr.equals("")) {
                number = Integer.parseInt(numberStr);
            }
            if (number == 0) {
                brandDAO.delete(id);
                List<BrandDTO> brandList = brandDAO.list();
                request.setAttribute("brandList", brandList);
                request.setAttribute("error", "Delete sucessfully");
                request.getRequestDispatcher("brandManagement.jsp").forward(request, response);
            } else {
                List<BrandDTO> brandList = brandDAO.list();
                request.setAttribute("brandList", brandList);
                request.setAttribute("error", "Cannot delete this brand (Has product)");
                request.getRequestDispatcher("brandManagement.jsp").forward(request, response);
            }

        } else if (action.equals("Update")) {
            String name = request.getParameter("name");
            String idStr = request.getParameter("id");

            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            if (name != null && !name.equals("")) {
                brandDAO.update(name, id);
            }
            response.sendRedirect("./Brand");

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
