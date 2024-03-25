package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import java.io.Serializable;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public int addProduct(Product product) {

        int pId = 0;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            pId = (int) session.save(product);

            tx.commit();
            session.close();
        } catch (Exception e) {
        }
        return pId;
    }

    public List<Product> getAllProducts() {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product");
        List<Product> list = query.list();
        s.close();
        return list;

    }

    public List<Product> getAllProductsById(int cid) {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product as p where p.category.categoryId =: id");
        query.setParameter("id", cid);
        List<Product> list = query.list();
        s.close();
        return list;
    
    }
    
    public int numOfProd(int cid){
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product as p where p.category.categoryId =: id");
        query.setParameter("id", cid);
        List<Product> list = query.list();
        s.close();
        return list.size();
    }
    
}
