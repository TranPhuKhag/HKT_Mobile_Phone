/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import dto.Cart;
import dto.Item;
import dto.ProductDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Administrator
 */
public class processCartController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();

            if (action.equals("check")) {
                String address = request.getParameter("address");
                Integer amount = Integer.parseInt(request.getParameter("amount"));
                Cart cart;
                Object o = (Cart) session.getAttribute("cart");
                if (o != null) {
                    cart = (Cart) o;
                } else {
                    cart = new Cart();
                }

                if (address == null) {
                    List<Item> list = cart.getItems();
                    session.setAttribute("size", list.size());
                    session.setAttribute("cart", cart);
                    request.setAttribute("message", "Enter Address Please");
                    request.getRequestDispatcher("cartList.jsp").forward(request, response);
                }
                cart.setAddressCart(address);
                cart.setAmountCart(amount);

                Object user = session.getAttribute("usersession");
                if (user != null) {
                    OrderDAO dao = new OrderDAO();
                    dao.addOrder((UserDTO) user, cart);
                    session.removeAttribute("cart");
                    session.setAttribute("size", 0);
                    response.sendRedirect("./Store");
                } else {
                    request.setAttribute("message", "Enter the login");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else if (action.equals("quantity")) {
                Cart cart;
                Object o = (Cart) session.getAttribute("cart");
                if (o != null) {
                    cart = (Cart) o;
                } else {
                    cart = new Cart();
                }
                Integer num = Integer.parseInt(request.getParameter("num"));
                Integer id = Integer.parseInt(request.getParameter("id"));

                try {
                    if ((num == -1) && (cart.getQuantityByID(id) <= 1)) {
                        cart.removeItemByID(id);
                    } else {
                        ProductDAO dao = new ProductDAO();
                        ProductDTO p = dao.getProductByID(id); // Lấy product của ID đó 
                        Item t = new Item(p, p.getPrice(), num);
                        cart.addItem(t);
                    }
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }
                List<Item> list = cart.getItems();
                session.setAttribute("size", list.size());
                session.setAttribute("cart", cart);
                request.getRequestDispatcher("cartList.jsp").forward(request, response);
            }
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
        HttpSession session = request.getSession(true);
        Cart cart = null;
        Object o = session.getAttribute("cart");
        if (o != null) {
            cart = (Cart) o;

        } else {
            cart = new Cart();
        }
        int id = Integer.parseInt(request.getParameter("id"));  // bắt cái ID muốn xoá Item đó 
        cart.removeItemByID(id);                       // dùng để xoá Item đó 
        List<Item> list = cart.getItems();

        session.setAttribute("size", list.size());
        session.setAttribute("cart", cart);
        request.getRequestDispatcher("cartList.jsp").forward(request, response);
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
