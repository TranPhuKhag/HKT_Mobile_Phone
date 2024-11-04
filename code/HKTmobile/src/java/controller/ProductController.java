/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.FeedbackDAO;
import dao.ProductDAO;
import dao.ProductDetailDAO;
import dao.ProductGroupDAO;
import dto.FeedbackDTO;
import dto.ProductDTO;
import dto.ProductDetailDTO;
import dto.ProductGroupDTO;
import dto.ProductImgDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class ProductController extends HttpServlet {

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
        ProductDAO productDAO = new ProductDAO();
        FeedbackDAO feedbackDao = new FeedbackDAO();
        ProductGroupDAO groupDAO = new ProductGroupDAO();
        ProductDetailDAO detailDao = new ProductDetailDAO();
        if (action == null || action.equals("detail")) {
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }

            ProductDTO product = productDAO.load(id);

            int ram = product.getRam();

            int storage = product.getStorage();
            List<ProductDTO> productlist = productDAO.listFirst(product.getGroupID());
            List<ProductDTO> productcolor = productDAO.list(product.getGroupID(), ram, storage);

            ProductDetailDTO detail = detailDao.load(product.getGroupID());

            ProductGroupDTO group = groupDAO.load(product.getGroupID());

            List<FeedbackDTO> feedback = feedbackDao.list(id);
            ArrayList<Integer> rateList = new ArrayList<>();
            float total = 0;
            for (int i = 1; i <= 5; i++) {
                int count = 0;
                for (FeedbackDTO feedbackDTO : feedback) {
                    if (feedbackDTO.getRate() == i) {
                        count++;
                        total += i;
                    }
                }
                rateList.add(count);
            }
            double number = total / feedback.size();
            double roundedNumber = Math.round(number * 10.0) / 10.0;

            product.setRate(roundedNumber);
            List<ProductGroupDTO> relatedGroup = groupDAO.searchlist4(group, product.getRam(), product.getStorage(),0);

            request.setAttribute("related", relatedGroup);
            request.setAttribute("rateList", rateList);
            request.setAttribute("feedbackList", feedback);
            request.setAttribute("detail", detail);
            request.setAttribute("productcolor", productcolor);
            request.setAttribute("product", product);
            request.setAttribute("productList", productlist);
            request.setAttribute("group", group);
            request.getRequestDispatcher("product.jsp").forward(request, response);

        } 
    }

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
