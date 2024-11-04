/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Administrator
 */
public class userController extends HttpServlet {

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
            UserDAO userDAO = new UserDAO();
            ArrayList<UserDTO> list = userDAO.getAll();
            request.setAttribute("list", list);
            request.getRequestDispatcher("User/userManagerment.jsp").forward(request, response);
        } else if (action.equals("detail")) {
            Integer userId = Integer.parseInt(request.getParameter("userId"));
            UserDAO userDAO = new UserDAO();

            UserDTO userDTO = null;
            if (userId != null) {
                userDTO = userDAO.getUserByID(userId);
            }

            request.setAttribute("user", userDTO);
            request.getRequestDispatcher("User/userDetail.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            UserDAO userDAO = new UserDAO();
            if (userID != null) {
                userDAO.delete(userID);
            }
            ArrayList<UserDTO> list = userDAO.getAll();
            request.setAttribute("list", list);

            request.getRequestDispatcher("User/userManagerment.jsp").forward(request, response);
        } /* else if (action.equals("create")) {
            UserDTO userDTO = new UserDTO();
            
            request.setAttribute("nextaction", "insert");
            request.setAttribute("user", userDTO);
            request.getRequestDispatcher("User/userEdit.jsp").forward(request, response);
        }
        
        
        
        else if (action.equals("insert")) {
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String passwword = request.getParameter("password");
            UserDTO userDTO = new UserDTO();
            userDTO.setUserID(0);
            userDTO.set
            ArrayList<UserDTO> list = new ArrayList<>();
            if (userID != null) {
                UserDAO userDAO = new UserDAO();
                list = userDAO.getAll();
                String results = "";
                for (int i = 0; i <list.size(); i++) {
                    if (userID == list.get(i).getUserID()) {
                        results = userID + "UserID này đã tồn tại ";
                    }
                    request.setAttribute("message", results);
                    request.setAttribute("list", userDTO);
                }
                if (userID == null || fullname.equals("") || email.equals("") || phone.equals("") || username.equals("") || passwword.equals("")) {

                    request.setAttribute("message", "Nhập đầy đủ thông tin người đùng");
                    request.setAttribute("list", userDTO);
                    request.getRequestDispatcher("User/userManagerment.jsp").forward(request, response);

                }else {
                    
                }

            }
                    request.setAttribute("list", list);


            request.getRequestDispatcher("User/userManagerment.jsp").forward(request, response);
        } */
        else if(action.equals("create")){
UserDAO userDAO = new UserDAO(); 
UserDTO userDTO = new UserDTO() ; 
request.setAttribute("user",userDTO);
request.setAttribute("nextaction","insert");
request.getRequestDispatcher("User/userAdd.jsp").forward(request, response);

}
else if (action.equals("insert")){
    Integer userID = Integer.parseInt(request.getParameter("userID"));
    String fullname = request.getParameter("fullname");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String username = request.getParameter("username");
String password = request.getParameter("password");
    int role =Integer.parseInt(request.getParameter("role"));
    int status = Integer.parseInt(request.getParameter("status"));
    UserDTO userDTO = new UserDTO();
    if(userID!=null ){
    UserDAO userDAO = new UserDAO();
    ArrayList<UserDTO> list = userDAO.getAll();
    String results = "";
        for (int i =0 ; i< list.size();i++){
     if(userID == list.get(i).getUserID()){       
          results =   userID + "UserID này đã tồn tại ";
    }
     request.setAttribute("message", results);
         request.setAttribute("list", userDTO);
    }
    if( fullname.equals("")||email.equals("")||phone.equals("")||username.equals("")||password.equals("")){
 
      request.setAttribute("message","Nhập đầy đủ tông tin người đùng");
      request.setAttribute("list", userDTO);
      
    }else {
     
    userDTO.setFullname(fullname);
    userDTO.setEmail(email);
    userDTO.setPhone(phone);
    userDTO.setUsername(username);
    userDTO.setPassword(password);
    userDTO.setRole(role);
    userDTO.setStatus(status);
      userDAO.insert(userDTO);
       list = userDAO.getAll();
       request.setAttribute("list", list);
       request.setAttribute("message","thêm vao thành công");
    }
         request.getRequestDispatcher("User/userManagerment.jsp").forward(request, response);

    }
}
        else if (action.equals("edit")) {
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            UserDAO userDAO = new UserDAO();
            UserDTO userDTO = new UserDTO();
            if (userID != null) {
                userDTO = userDAO.getUserByID(userID);
            }
            request.setAttribute("nextaction", "update");
            request.setAttribute("user", userDTO);
            request.getRequestDispatcher("User/userEdit.jsp").forward(request, response);
        } else if (action.equals("update")) {
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            int role = Integer.parseInt(request.getParameter("role"));
            int status = Integer.parseInt(request.getParameter("status"));
            UserDAO userDAO = new UserDAO();
            UserDTO userDTO = new UserDTO();
            userDTO.setUserID(userID);
            userDTO.setFullname(fullname);
            userDTO.setEmail(email);
            userDTO.setPhone(phone);
            userDTO.setUsername(username);
            userDTO.setPassword(password);
            userDTO.setRole(role);
            userDTO.setStatus(status);
            System.out.println(role);
            System.out.println(status);
            if (userID != null) {
                userDAO.update(userDTO);
            }
            ArrayList<UserDTO> list = new ArrayList<>();
            list = userDAO.getAll();
            request.setAttribute("list", list);
            request.getRequestDispatcher("User/userManagerment.jsp").forward(request, response);
        }
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
