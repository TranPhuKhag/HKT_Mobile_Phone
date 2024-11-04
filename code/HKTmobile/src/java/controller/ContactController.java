/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ContactUsDAO;
import dto.ContactUsDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Asus
 */
@WebServlet(name = "ContactController", urlPatterns = {"/ContactController"})
public class ContactController extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        
        if(action.equals("contact")){
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            String message = request.getParameter("message");
            
            ContactUsDAO contactDAO = new ContactUsDAO();
            ContactUsDTO contactDTO = new ContactUsDTO();
            contactDTO.setUserID(userID);
            contactDTO.setMessage(message);
            contactDTO.setDate(new java.util.Date());
            contactDAO.saveContact(contactDTO);
            request.setAttribute("contactList", contactDTO);
            response.sendRedirect("userContact.jsp");
        } 
        else if(action.equals("view")){
            Integer userID = Integer.parseInt(request.getParameter("userID"));
            ContactUsDAO contactDAO = new ContactUsDAO();
            List<ContactUsDTO> contactList = new ArrayList<>();
            if(userID != null){
                contactList = contactDAO.getContactsByUser(userID);
            }
            request.setAttribute("contactList", contactList);
            request.getRequestDispatcher("contacting.jsp").forward(request, response);
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    
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

 
    @Override
    public String getServletInfo() {
        return "Contact Controller Servlet";
    }// </editor-fold>

}
