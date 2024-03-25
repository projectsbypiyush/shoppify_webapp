/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.servlets;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;
import com.mysql.cj.jdbc.interceptors.SessionAssociationInterceptor;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author wankh
 */

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            String op = request.getParameter("operation");
            if(op.trim().equals("addCategory")){
                
                String catName = request.getParameter("catName");
                String catDetails = request.getParameter("catDetails");
                
                Category cat = new Category();
                cat.setCategoryTitle(catName);
                cat.setCategoryDesc(catDetails);
                
                //save category to db
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.addCategory(cat);                
                //out.println("Category saved with id: "+catId);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category successfully added with id: "+catId);
                response.sendRedirect("admin.jsp");
                
            } 
            else if(op.trim().equals("updateCategory")){
                
                int cId = Integer.parseInt(request.getParameter("catId"));
                String catName = request.getParameter("catName");
                String catDetails = request.getParameter("catDetails");
                
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                categoryDao.updateCategory(cId, catName, catDetails);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category successfully updated with category id: "+cId);
                response.sendRedirect("view_categories.jsp");
                
                
            }
            
            else if(op.trim().equals("deleteCategory")){
                int cId = Integer.parseInt(request.getParameter("catId"));
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                categoryDao.deleteCategory(cId);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category successfully deleted with category id: "+cId);
                response.sendRedirect("view_categories.jsp");
                
            }
            
            else if(op.trim().equals("addProduct")){
                
                String pName = request.getParameter("pName");
                String pDetails = request.getParameter("pDetails");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQty = Integer.parseInt(request.getParameter("pQty"));
                int pCategory = Integer.parseInt(request.getParameter("pCategory"));
                Part pImg = request.getPart("pImg");
               
                
                Product product = new Product();
                product.setpName(pName);
                product.setpDesc(pDetails);
                product.setpPrice(pPrice);
                product.setpDiscount(pDiscount);
                product.setpQty(pQty);
                product.setpPic(pImg.getSubmittedFileName());
                                
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                Category cId = categoryDao.getCategoryById(pCategory);
                
                product.setCategory(cId);
                
                ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
                int pId = pDao.addProduct(product);
                //out.print("Product succefully added with product id: "+pId);
                
                //add product img to products folder
                String path = request.getRealPath("img") + File.separator + "products" + File.separator + pImg.getSubmittedFileName();
                System.out.println(path);
                
                try {
                    
                    FileOutputStream fos = new FileOutputStream(path);
                    
                    InputStream is = pImg.getInputStream();
                    
                    //reading data
                    byte[] data = new byte[is.available()];
                    
                    is.read(data);
                    
                    //writing data
                    fos.write(data);
                    
                    is.close();
                    fos.close();
                                       
                } catch (Exception e) {
                    
                    e.printStackTrace();
                }
                  
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Product successfully added with product id: "+pId);
                response.sendRedirect("admin.jsp");
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
