/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BrandDAO;
import dao.ContactUsDAO;
import dto.ContactUsDTO;
import dao.FeedbackDAO;
import dao.ProductDAO;
import dao.ProductDetailDAO;
import dao.ProductGroupDAO;
import dto.BrandDTO;
import dto.FeedbackDTO;
import dto.ProductDTO;
import dto.ProductDetailDTO;

import dto.ProductGroupDTO;
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
public class AdminController extends HttpServlet {

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
        BrandDAO Bdao = new BrandDAO();
        List<BrandDTO> brandlist = Bdao.list();
        int PRODUCTS_PER_PAGE = 6;
        ProductGroupDAO groupDAO = new ProductGroupDAO();
        ProductDAO productDAO = new ProductDAO();
        FeedbackDAO feedbackDao = new FeedbackDAO();
        ProductDetailDAO detailDao = new ProductDetailDAO();
        if (action == null || action.equals("list")) {

            ProductGroupDAO dao = new ProductGroupDAO();
            String keyword = request.getParameter("keyword");
            String brandName = request.getParameter("BrandName");
            if(brandName!=null&&brandName.equals("All")){
                brandName="";
            }
            String ramStr = request.getParameter("Ram");
            int ram = 0;
            if (ramStr != null && !ramStr.equals("")) {
                ram = Integer.parseInt(ramStr);
            }
            String storageStr = request.getParameter("Storage");
            int storage = 0;
            if (storageStr != null && !storageStr.equals("")) {
                storage = Integer.parseInt(storageStr);
            }
            String sortBy = request.getParameter("sortBy");
            String sortType = request.getParameter("SortType");
            String page = request.getParameter("page");
            int currentPage = 1;
            if (page != null && !page.equals("")) {
                currentPage = Integer.parseInt(page);
            }
           
            String pminStr = request.getParameter("pricemin");
            double pmin = 0;
            if (pminStr != null && !pminStr.equals("")) {
                pmin = Double.parseDouble(pminStr);
            }

            String pmaxStr = request.getParameter("pricemax");
            double pmax = 0;
            if (pmaxStr != null && !pmaxStr.equals("")) {
                pmax = Double.parseDouble(pmaxStr);
            }

            int totalProducts = dao.listNum(brandName, ram, storage,  pmin, pmax, keyword);


            int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

            

            int startIndex = (currentPage - 1) * PRODUCTS_PER_PAGE;

            List<ProductGroupDTO> currentPageList = dao.searchlist(brandName, ram, storage, sortBy, sortType, pmin, pmax, keyword, startIndex);
            
            // Đặt các thuộc tính yêu cầu
            request.setAttribute("Grouplist", currentPageList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("PageSize", PRODUCTS_PER_PAGE);
            // Chuyển tiếp yêu cầu đến JSP
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("BrandName", brandName);
            request.setAttribute("Ram", ramStr);
            request.setAttribute("Storage", storageStr);
            request.setAttribute("SortBy", sortBy);
            request.setAttribute("SortType", sortType);
            request.setAttribute("Pmin", pminStr);
            request.setAttribute("Pmax", pmaxStr);
            request.setAttribute("keyword", keyword);
            request.setAttribute("Brandlist", brandlist);
            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
        }

        
        else if(action.equals("contactManagement")){
            ContactUsDAO contactDao = new ContactUsDAO();
            ArrayList<ContactUsDTO> contactDto = (ArrayList<ContactUsDTO>) contactDao.contactDao();
            for (ContactUsDTO contactUsDTO : contactDto) {
                System.out.println(contactUsDTO.getMessage());
            }
            request.setAttribute("contactDto", contactDto);
            request.getRequestDispatcher("adminContact.jsp").forward(request, response);

        }else if (action.equals("Product")) {
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

            request.setAttribute("feedbackList", feedback);
            request.setAttribute("detail", detail);
            request.setAttribute("productcolor", productcolor);
            request.setAttribute("product", product);
            request.setAttribute("productList", productlist);
            request.setAttribute("group", group);
            request.getRequestDispatcher("productView.jsp").forward(request, response);
        } else if (action.equals("Edit")) {
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            ProductDTO product = productDAO.load(id);
            request.setAttribute("product", product);
            request.getRequestDispatcher("productEdit.jsp").forward(request, response);
        } else if (action.equals("Save")) {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            String[] imgUrls = request.getParameterValues("img[]");
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            String ramStr = request.getParameter("Ram");
            int ram = 0;
            if (ramStr != null && !ramStr.equals("")) {
                ram = Integer.parseInt(ramStr);
            }
            String storageStr = request.getParameter("Storage");
            int storage = 0;
            if (storageStr != null && !storageStr.equals("")) {
                storage = Integer.parseInt(storageStr);
            }
            String color = request.getParameter("color");
            String priceStr = request.getParameter("price");
            int price = 0;
            if (priceStr != null && !priceStr.equals("")) {
                price = Integer.parseInt(priceStr);
            }
            productDAO.updateProduct(id, ram, color, storage, price, imgUrls);
            response.sendRedirect("./Admin?action=Product&&id=" + id);
        } else if (action.equals("Create")) {
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            ProductGroupDTO group = groupDAO.load(groupID);
            request.setAttribute("group", group);
            request.getRequestDispatcher("productInsert.jsp").forward(request, response);
        } else if (action.equals("Insert")) {
            String[] imgUrls = request.getParameterValues("img[]");
            String ramStr = request.getParameter("Ram");
            int ram = 0;
            if (ramStr != null && !ramStr.equals("")) {
                ram = Integer.parseInt(ramStr);
            }
            String storageStr = request.getParameter("Storage");
            int storage = 0;
            if (storageStr != null && !storageStr.equals("")) {
                storage = Integer.parseInt(storageStr);
            }
            String color = request.getParameter("color");
            String priceStr = request.getParameter("price");
            int price = 0;
            if (priceStr != null && !priceStr.equals("")) {
                price = Integer.parseInt(priceStr);
            }
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            ProductDTO product = productDAO.load(groupID, ram, color, storage, price);
            if (product == null) {
                productDAO.insertProduct(groupID, ram, color, storage, price, imgUrls);
                int id = productDAO.loadNewID();
                response.sendRedirect("./Admin?action=Product&&id=" + id);
            } else {
                request.setAttribute("error", "product has exist");
                request.getRequestDispatcher("productInsert.jsp").forward(request, response);
            }

        } else if (action.equals("Delete")) {
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            ProductDTO product = productDAO.load(id);           
            productDAO.delete(id);
            List<ProductDTO> productlist = productDAO.listFirst(product.getGroupID());
            ProductDTO sameProduct = productlist.get(0);
            response.sendRedirect("./Admin?action=Product&&id=" + sameProduct.getProductID());
        } else if (action.equals("Add Img")) {
            String img = request.getParameter("img");
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            if (id != 0 && img != null && !img.equals("")) {
                productDAO.insertImg(id, img);
            }
            response.sendRedirect("./Admin?action=Product&&id=" + id);
        } else if (action.equals("remove")) {
                        String imgStr = request.getParameter("img");
            int img = 0;
            if (imgStr != null && !imgStr.equals("")) {
                img = Integer.parseInt(imgStr);
            }
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            if(id!=0){
                productDAO.deleteImg(img);
            }  
        response.sendRedirect("./Admin?action=Edit&&id=" + id);

        }if (action.equals("Search")) {

            ProductGroupDAO dao = new ProductGroupDAO();
            String keyword = request.getParameter("keyword");
            String brandName = request.getParameter("BrandName");
            if (brandName != null && brandName.equals("All")) {
                brandName = "";
            }
            String ramStr = request.getParameter("Ram");
            int ram = 0;
            if (ramStr != null && !ramStr.equals("")) {
                ram = Integer.parseInt(ramStr);
            }
            String storageStr = request.getParameter("Storage");
            int storage = 0;
            if (storageStr != null && !storageStr.equals("")) {
                storage = Integer.parseInt(storageStr);
            }
            String sortBy = request.getParameter("sortBy");
            String sortType = request.getParameter("SortType");
            String page = request.getParameter("page");
            int currentPage = 1;
            if (page != null && !page.equals("")) {
                currentPage = Integer.parseInt(page);
            }

            String pminStr = request.getParameter("pricemin");
            double pmin = 0;
            if (pminStr != null && !pminStr.equals("")) {
                pmin = Double.parseDouble(pminStr);
            }

            String pmaxStr = request.getParameter("pricemax");
            double pmax = 0;
            if (pmaxStr != null && !pmaxStr.equals("")) {
                pmax = Double.parseDouble(pmaxStr);
            }

            int totalProducts = dao.listNum(brandName, ram, storage, pmin, pmax, keyword);
            System.out.println(totalProducts);
            int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

            int startIndex = (currentPage - 1) * PRODUCTS_PER_PAGE;

            List<ProductGroupDTO> currentPageList = dao.searchlistUser(brandName, ram, storage, sortBy, sortType, pmin, pmax, keyword, startIndex);

            // Đặt các thuộc tính yêu cầu
            request.setAttribute("Grouplist", currentPageList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("PageSize", PRODUCTS_PER_PAGE);
            // Chuyển tiếp yêu cầu đến JSP
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("BrandName", brandName);
            request.setAttribute("Ram", ramStr);
            request.setAttribute("Storage", storageStr);
            request.setAttribute("SortBy", sortBy);
            request.setAttribute("SortType", sortType);
            request.setAttribute("Pmin", pminStr);
            request.setAttribute("Pmax", pmaxStr);
            request.setAttribute("keyword", keyword);
            request.setAttribute("Brandlist", brandlist);
            request.getRequestDispatcher("productManagement.jsp").forward(request, response);
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
