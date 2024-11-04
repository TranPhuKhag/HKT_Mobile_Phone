/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ProductDAO;
import dao.ProductGroupDAO;
import dao.UserDAO;
import dto.OrderDTO;
import dto.ProductDTO;
import dto.UserDTO;
import java.awt.Point;
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
 * @author Administrator
 */
public class invoiceController extends HttpServlet {

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
        if (action == null || action.equals("list")) {
            OrderDAO orderDAO = new OrderDAO();
            ArrayList<OrderDTO> list = orderDAO.getOrder();
            request.setAttribute("list", list);
            request.getRequestDispatcher("invoice/invoice.jsp").forward(request, response);
        } else if (action.equals("detail")) {
            OrderDAO orderDAO = new OrderDAO();
            List<ProductDTO>  product = new ArrayList<>();
            ProductDAO productDAO  = new ProductDAO();
            ProductGroupDAO pruGroupDAO = new ProductGroupDAO();
            ArrayList<OrderDTO> orderDTO = new ArrayList<>();
            Integer id = Integer.parseInt(request.getParameter("id"));
            if (id != null) {
                orderDTO = orderDAO.getOrderByOrderID(id);
            }
            request.setAttribute("list", orderDTO);
            request.getRequestDispatcher("invoice/invoiceDetail.jsp").forward(request, response);
            
            
            
            
        }else if (action.equals("deleteProduct")){
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            Integer id = Integer.parseInt(request.getParameter("id"));
            Integer productID = Integer.parseInt(request.getParameter("productID"));
            ArrayList<OrderDTO> orderDTO = new ArrayList<>();
            Integer amount = Integer.parseInt(request.getParameter("amounts"));
            Integer totalID = Integer.parseInt(request.getParameter("totalID"));
            
            
            
            if (amount != null) {
                orderDAO.updateAmountByID(id, amount);

            }
            Integer total = Integer.parseInt(request.getParameter("totalprices"));
            if (total != null) {
                orderDetailDAO.updateTotalByID(id, totalID);
            }

            if (productID != null) {
                orderDetailDAO.deleteByProductID(productID);
                orderDTO = orderDAO.getOrderByOrderID(id);
            }
            request.setAttribute("list", orderDTO);
            request.getRequestDispatcher("invoice/invoiceDetail.jsp").forward(request, response);

        } else if (action.equals("editUser")) {
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            Integer orderID = Integer.parseInt(request.getParameter("orderID"));
            UserDTO userDTO = new UserDTO();
            OrderDTO orderDTO = new OrderDTO();
            UserDAO userDAO = new UserDAO();
            OrderDAO orderDAO = new OrderDAO();
            if (userID != null) {
                userDTO = userDAO.getUserByID(userID);
            }
            if (orderID != null) {
                orderDTO = orderDAO.getOrderByID(orderID);
            }
            request.setAttribute("user", userDTO);
            request.setAttribute("order", orderDTO);
            request.getRequestDispatcher("invoice/invoiceEditUser.jsp").forward(request, response);

        } else if (action.equals("updateUser")) {

            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String date = request.getParameter("date");
            String address = request.getParameter("address");
            Integer statusID = Integer.parseInt(request.getParameter("statusID"));
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            Integer orderID = Integer.parseInt(request.getParameter("orderID"));
            ArrayList<OrderDTO> orderDTO = new ArrayList<>();
            UserDAO userDAO = new UserDAO();
            OrderDAO orderDAO = new OrderDAO();
            if (userID != null) {
                userDAO.updateInvoiceByID(userID, fullname, email, phone);
            }
            if (orderID != null) {
                orderDAO.updateInvoiceByID(orderID, date, address, statusID);
                orderDTO = orderDAO.getOrderByOrderID(orderID);
            }

            request.setAttribute("list", orderDTO);
            request.getRequestDispatcher("invoice/invoiceDetail.jsp").forward(request, response);
        } else if (action.equals("editProduct")) {

            Integer groupID = Integer.parseInt(request.getParameter("groupID"));
            ProductDAO productDAO = new ProductDAO();
            ArrayList<ProductDTO> productDTO = new ArrayList<>();
            List<ProductDTO> list = productDAO.list(groupID);
            if (groupID != null) {
                productDTO = productDAO.getProductByGroupID(groupID);
            }
            request.setAttribute("product", productDTO);
            request.setAttribute("list", list);

            request.getRequestDispatcher("invoice/invoiceEditProduct.jsp").forward(request, response);
        } else if (action.equals("updateProduct")) {
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            Integer id = Integer.parseInt(request.getParameter("id"));
            Integer productID = Integer.parseInt(request.getParameter("productID"));

            ArrayList<OrderDTO> orderDTO = new ArrayList<>();
            if (productID != null) {
                orderDetailDAO.deleteByProductID(productID);
                orderDTO = orderDAO.getOrderByOrderID(id);
            }
            request.setAttribute("list", orderDTO);
            request.getRequestDispatcher("invoice/invoiceDetail.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            ArrayList<OrderDTO> list = new ArrayList<>();
            OrderDAO orderDAO = new OrderDAO();

            if (id != null) {
                orderDAO.deleteByOrderID(id);

            }
            list = orderDAO.getOrder();
            request.setAttribute("list", list);
            request.getRequestDispatcher("invoice/invoice.jsp").forward(request, response);
        } else if (action.equals("orderDetailList")) {
            Integer orderID = Integer.parseInt(request.getParameter("orderID"));
            OrderDAO orderDAO = new OrderDAO();
            List<OrderDTO> orderDTO = new ArrayList<>();
            if (orderID != null) {
                orderDTO = orderDAO.getOrderByOrderID(orderID);
            }
            request.setAttribute("orderDetailList", orderDTO);
            request.getRequestDispatcher("orderDetailList.jsp").forward(request, response);
        } else if (action.equals("orderList")) {
            Integer userId = Integer.parseInt(request.getParameter("userId"));
            OrderDAO orderDAO = new OrderDAO();
            ArrayList<OrderDTO> orderDTO = new ArrayList<>();
            if (userId != null) {
                orderDTO = orderDAO.getOrder(userId);
            }
            request.setAttribute("orderList", orderDTO);
            request.getRequestDispatcher("OrderList.jsp").forward(request, response);
        } else if (action.equals("deleteOrder")) {
            Integer orderID = Integer.parseInt(request.getParameter("orderID"));
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            OrderDAO dao = new OrderDAO();
            if (orderID != null) {
                dao.DeleteOrder(orderID);
            }
            System.out.println("da chay");
            ArrayList<OrderDTO> dto = dao.getOrderAfterDelete(userID);
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
