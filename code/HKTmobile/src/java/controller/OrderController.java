/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDAO;
import dto.OrderDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class OrderController extends HttpServlet {

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
        String action=request.getParameter("action");
     if(action.equals("orderDetailList")){
          Integer orderID = Integer.parseInt(request.getParameter("orderID"));
          OrderDAO orderDAO = new OrderDAO();
          List<OrderDTO> orderDTO = new ArrayList<>();
          if(orderID != null){
          orderDTO = orderDAO.getOrderByOrderID(orderID);
                  }
          request.setAttribute("orderDetailList", orderDTO);
          request.getRequestDispatcher("orderDetailList.jsp").forward(request, response);
      }
      
      else if(action.equals("orderList")){
          Integer userId = Integer.parseInt(request.getParameter("userId"));
          OrderDAO orderDAO = new OrderDAO();
          ArrayList<OrderDTO> orderDTO = new ArrayList<>();
          if(userId != null){
              orderDTO = orderDAO.getOrder(userId);
          }
          request.setAttribute("orderList", orderDTO);
          request.getRequestDispatcher("OrderList.jsp").forward(request, response);
      }
      
      else if(action.equals("deleteOrder")){
          Integer orderID = Integer.parseInt(request.getParameter("orderID"));
          Integer userID = Integer.parseInt(request.getParameter("userID"));
          OrderDAO dao = new OrderDAO();
          if(orderID != null){
          dao.DeleteOrder(orderID);
          }
          
          ArrayList<OrderDTO> dto = dao.getOrder(userID);
          request.setAttribute("orderList", dto);
          request.getRequestDispatcher("OrderList.jsp").forward(request, response);
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
