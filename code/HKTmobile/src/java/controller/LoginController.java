/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dto.UserDTO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/Login"})
public class LoginController extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String action = request.getParameter("action"); //Lấy tham số action từ yêu cầu. Tham số này được dùng để xác định hành động là đăng nhập hay đăng xuất.
            String username = request.getParameter("user");
            String password = request.getParameter("password");
            UserDAO dao = new UserDAO();
             UserDTO user = dao.login(username, password);

            if (action == null || action.equals("login")) { //Kiểm tra nếu hành động là null hoặc là login.       

                if (user != null) { //Nếu người dùng tồn tại (thông tin đăng nhập đúng).
                    if (user.getRole() == 0 && user.getStatus() == 0) { //Nếu người dùng có vai trò là người dùng bình thường và trạng thái là hoạt động.
                        HttpSession session = request.getSession(true); //Tạo hoặc lấy phiên làm việc hiện tại.
                        session.setAttribute("usersession", user); //Lưu thông tin người dùng vào phiên làm việc.
                        response.sendRedirect("./Homepage"); //Chuyển hướng tới trang chủ.
                    } else if (user.getRole() == 1) { //Nếu người dùng có vai trò là quản trị viên.
                        HttpSession session = request.getSession(true); //Tạo hoặc lấy phiên làm việc hiện tại
                        session.setAttribute("usersession", user); //Lưu thông tin người dùng vào phiên làm việc.
                        response.sendRedirect("./Homepage"); //Chuyển hướng tới trang quản trị.
                    } else { //Nếu người dùng bị cấm (status khác 0)
                        request.setAttribute("error", "You have been banned");
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        rd.forward(request, response);
                    }
                }else if(username==null||username.equals("")||password==null||password.equals("")){  
                                        request.setAttribute("error", "You must fill all information"); // nếu username và Password rỗng thì hiện ra cái này 
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp"); // trả lại để nhập lại
                        rd.forward(request, response);
                } else if (username == null || username.equals("") || password == null || password.equals("")) {
                    request.setAttribute("error", "You must fill all information"); // nếu username và Password rỗng thì hiện ra cái này 
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp"); // trả lại để nhập lại
                    rd.forward(request, response);
                } else {  // Nếu thông tin đăng nhập không đúng.
                    request.setAttribute("error", "Username or password is incorrect");
                    request.setAttribute("username", username);
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
            } else if (action.equals("logout")) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                    request.setAttribute("error", "Log out successfully");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
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
