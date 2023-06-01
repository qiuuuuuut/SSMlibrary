package com.library.dao;

import com.library.bean.Book;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BookDao {

    private final static String NAMESPACE = "com.library.dao.BookDao.";
    //sqlSessionTemplate方法里面第一个参数是mapper的id；
    // 第二个参数是需要传递的参数，在mapper里面可以用#{...}来调用
    @Resource
    private SqlSessionTemplate sqlSessionTemplate;

    //显示匹配书的数量，用于判断查找的时候是不是有匹配的书，没有的话，会出现‘没有匹配的书’
    public int matchBook(String author,String publish,String name) {
        Map<String, Object> paramMap = new HashMap<>();
        String author1 = "%" + author + "%";
        String publish1 = "%" + publish + "%";
        String name1 = "%" + name + "%";
        paramMap.put("author", author1);
        paramMap.put("publish", publish1);
        paramMap.put("name", name1);
        return sqlSessionTemplate.selectOne(NAMESPACE + "matchBook", paramMap);
    }

    public ArrayList<Book> queryBook(String author,String publish,String name) {
        Map<String, Object> paramMap = new HashMap<>();
        String author1 = "%" + author + "%";
        String publish1 = "%" + publish + "%";
        String name1 = "%" + name + "%";
        paramMap.put("author", author1);
        paramMap.put("publish", publish1);
        paramMap.put("name", name1);
        List<Book> result = sqlSessionTemplate.selectList(NAMESPACE + "queryBook", paramMap);
        return (ArrayList<Book>) result;
    }

    public ArrayList<Book> getAllBooks() {
        List<Book> result = sqlSessionTemplate.selectList(NAMESPACE + "getAllBooks");
        return (ArrayList<Book>) result;
    }

    public int addBook(final Book book) {
        return sqlSessionTemplate.insert(NAMESPACE + "addBook", book);
    }

    public Book getBook(final long bookId) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getBook", bookId);
    }

    public int editBook(final Book book) {
        return sqlSessionTemplate.update(NAMESPACE + "editBook", book);
    }

    public int deleteBook(final long bookId) {
        return sqlSessionTemplate.delete(NAMESPACE + "deleteBook", bookId);
    }
}
