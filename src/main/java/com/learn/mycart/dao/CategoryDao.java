package com.learn.mycart.dao;

import org.hibernate.SessionFactory;
import com.learn.mycart.entities.Category;
import java.io.Serializable;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    //saves the category to db
    public int addCategory(Category cat) {
        int catId = 0;

        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            catId = (int) session.save(cat);
            tx.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return catId;

    }
    
    public void updateCategory(Category cat) {

        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.saveOrUpdate(cat);
            tx.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    
     public void updateCategory(int catId, String newTitle, String newDetails) 
     {
        // Get the Hibernate session
        Session session = this.factory.openSession();
        Transaction transaction = null;

        try {
            // Begin transaction
            transaction = session.beginTransaction();
            
            // Retrieve the Category object from the database based on catId
            Category category = session.get(Category.class, catId);
            
            // Check if the category exists
            if (category != null) {
                // Update the attributes of the Category object
                category.setCategoryTitle(newTitle);
                category.setCategoryDesc(newDetails);
                System.out.println("Category with ID " + catId + " not found.");
                
                // Commit the transaction
                session.saveOrUpdate(category);
                transaction.commit();
            } else {
                System.out.println("Category with ID " + catId + " not found.");
            }
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            // Close the session
            session.close();
        }
    }


    public List<Category> getCategories() {
        Session session = this.factory.openSession();
        Query q = session.createQuery("from Category");
        List<Category> list = q.list();
        session.close();

        return list;
    }
    

    public Category getCategoryById(int catId) {

        Category category = null;
        try {

            Session session = this.factory.openSession();
            category = session.get(Category.class, catId);
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }

    public boolean deleteCategoryById(Class<?> type, Serializable id) {
        Session session = this.factory.openSession();
        Object persistentInstance = session.load(type, id);
        if (persistentInstance != null) {
            session.delete(persistentInstance);
            return true;
        }
        session.delete(persistentInstance);
        return false;
    }
    
    // Method to delete a Category object by ID
    public void deleteCategory(int catId) {
        // Get the Hibernate session
        Session session = this.factory.openSession();
        Transaction transaction = null;

        try {
            // Begin transaction
            transaction = session.beginTransaction();
            
            // Retrieve the Category object from the database based on catId
            Category category = session.get(Category.class, catId);
            
            // Check if the category exists
            if (category != null) {
                // Delete the category
                session.delete(category);
                
                // Commit the transaction
                transaction.commit();
                System.out.println("Category with ID " + catId + " deleted successfully.");
            } else {
                System.out.println("Category with ID " + catId + " not found.");
            }
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            // Close the session
            session.close();
        }
    }
}

