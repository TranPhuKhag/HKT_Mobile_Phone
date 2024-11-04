/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BrandDAO;
import dao.ProductDetailDAO;
import dao.ProductGroupDAO;
import dto.BrandDTO;
import dto.ProductDetailDTO;
import dto.ProductGroupDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProductGroupController", urlPatterns = {"/ProductGroupController"})
public class ProductGroupController extends HttpServlet {

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
        List<BrandDTO> brandlist = Bdao.listUser();
        int PRODUCTS_PER_PAGE = 6;
        ProductGroupDAO groupDAO = new ProductGroupDAO();
        ProductDetailDAO detailDAO = new ProductDetailDAO();
        if (action == null || action.equals("Search")) {

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
            request.getRequestDispatcher("store.jsp").forward(request, response);
        } else if (action.equals("Detail")) {
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            ProductGroupDTO product = groupDAO.load(groupID);
            ProductDetailDTO detail = detailDAO.load(groupID);

            request.setAttribute("product", product);
            request.setAttribute("detail", detail);
            request.getRequestDispatcher("productGroupView.jsp").forward(request, response);
        } else if (action.equals("Create")) {
            request.setAttribute("brandlist", brandlist);
            request.getRequestDispatcher("productGroupInsert.jsp").forward(request, response);
        } else if (action.equals("Edit")) {
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            ProductGroupDTO product = groupDAO.load(groupID);
            ProductDetailDTO detail = detailDAO.load(groupID);
            request.setAttribute("brandlist", brandlist);
            request.setAttribute("product", product);
            request.setAttribute("detail", detail);
            request.getRequestDispatcher("productGroupEdit.jsp").forward(request, response);
        } else if (action.equals("Delete")) {
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            groupDAO.deleteByGroupID(groupID);
            response.sendRedirect("./Admin");
        } else if (action.equals("Save")) {
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            String productName = request.getParameter("productName");
            String brandIDStr = request.getParameter("brandID");
            int brandID = 0;
            if (brandIDStr != null && !brandIDStr.equals("")) {
                brandID = Integer.parseInt(brandIDStr);
            }
            String description = request.getParameter("description");
            String screen = request.getParameter("screen");
            String os = request.getParameter("os");
            String afterCam = request.getParameter("afterCam");
            String frontCam = request.getParameter("frontCam");
            String chip = request.getParameter("chip");
            String sim = request.getParameter("sim");
            String pin = request.getParameter("pin");
            String img = request.getParameter("img");

            ProductGroupDTO product = new ProductGroupDTO(groupID, productName, brandID, description, img);
            groupDAO.update(product);
            ProductDetailDTO detail = new ProductDetailDTO(groupID, screen, os, afterCam, frontCam, chip, sim, pin);
            detailDAO.update(detail);
            ProductGroupDTO productNew = groupDAO.load(groupID);
            ProductDetailDTO detailNew = detailDAO.load(groupID);

            request.setAttribute("product", productNew);
            request.setAttribute("detail", detailNew);
            request.getRequestDispatcher("productGroupView.jsp").forward(request, response);
        } else if (action.equals("Add")) {
            String productName = request.getParameter("productName");
            String brandIDStr = request.getParameter("brandID");
            int brandID = 0;
            if (brandIDStr != null && !brandIDStr.equals("")) {
                brandID = Integer.parseInt(brandIDStr);
            }
            String description = request.getParameter("description");
            String screen = request.getParameter("screen");
            String os = request.getParameter("os");
            String afterCam = request.getParameter("afterCam");
            String frontCam = request.getParameter("frontCam");
            String chip = request.getParameter("chip");
            String sim = request.getParameter("sim");
            String pin = request.getParameter("pin");
            String img = request.getParameter("img");

            ProductGroupDTO product = new ProductGroupDTO(productName, brandID, description, img);
            groupDAO.insert(product);
            ProductGroupDTO newProduct = groupDAO.loadByName(productName);

            ProductDetailDTO detail = new ProductDetailDTO(newProduct.getGroupID(), screen, os, afterCam, frontCam, chip, sim, pin);
            detailDAO.insert(detail);
            ProductDetailDTO detailNew = detailDAO.load(newProduct.getGroupID());
            request.setAttribute("product", newProduct);
            request.setAttribute("detail", detailNew);
            request.getRequestDispatcher("productGroupView.jsp").forward(request, response);
        } else if (action.equals("Product")) {
            String idStr = request.getParameter("id");
            int id = 0;
            if (idStr != null && !idStr.equals("")) {
                id = Integer.parseInt(idStr);
            }
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            if (id == 0) {
                response.sendRedirect("./Admin?action=Create&groupID="+groupID);
            } else {
                request.getRequestDispatcher("./Admin").forward(request, response);
            }
        } else if (action.equals("Set Discount")) {
            String groupIDStr = request.getParameter("groupID");
            int groupID = 0;
            if (groupIDStr != null && !groupIDStr.equals("")) {
                groupID = Integer.parseInt(groupIDStr);
            }
            String discountStr = request.getParameter("discount");
            int discount = 0;
            if (discountStr != null && !discountStr.equals("")) {
                discount = Integer.parseInt(discountStr);
            }
            groupDAO.updateDiscount(discount, groupID);
            ProductGroupDTO product = groupDAO.load(groupID);
            ProductDetailDTO detail = detailDAO.load(groupID);

            request.setAttribute("product", product);
            request.setAttribute("detail", detail);
            request.getRequestDispatcher("productGroupView.jsp").forward(request, response);
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
