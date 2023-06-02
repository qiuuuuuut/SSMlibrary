package com.library.service;

import com.library.bean.Book;
import com.library.dao.BookDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class BookService {
    @Autowired
    private BookDao bookDao;

    public ArrayList<Book> queryBook(String author,String publish,String name,String class_name) {
        return bookDao.queryBook(author,publish,name,class_name);
    }

    public ArrayList<Book> getAllBooks() {
        return bookDao.getAllBooks();
    }

    public ArrayList<Book> getAllBooksByReader(long reader_id) {
        return bookDao.getAllBooksByReader(reader_id);
    }

    public boolean matchBook(String author,String publish,String name,String class_name) {
        return bookDao.matchBook(author,publish,name,class_name) > 0;
    }

    public boolean addBook(Book book) {
        return bookDao.addBook(book) > 0;
    }

    public Book getBook(Long bookId) {
        return bookDao.getBook(bookId);
    }

    public boolean editBook(Book book) {
        return bookDao.editBook(book) > 0;
    }

    public boolean deleteBook(Long bookId) {
        return bookDao.deleteBook(bookId) > 0;
    }

}
