
package com.learn.mycart.servlets;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import com.mysql.cj.jdbc.interceptors.SessionAssociationInterceptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;


public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            try {
                
                String userName = request.getParameter("name");
                String userEmail = request.getParameter("email");
                String userPassword = request.getParameter("password");
                String userPhone = request.getParameter("phone");
                String userAddress = request.getParameter("address");
                
                //validations
                
                //creating user object to store data
                User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "normal");
                
                
                
                int userId;
                try (Session hibernateSession = FactoryProvider.getFactory().openSession()) {
                    Transaction tx = hibernateSession.beginTransaction();
                    userId = (int) hibernateSession.save(user);
                    tx.commit();
                    hibernateSession.close();
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("message", "User registration Successfull");
                    response.sendRedirect("register.jsp");
                    return;
                }
                
                
                
                
            } catch (Exception e) {
                e.printStackTrace();
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
