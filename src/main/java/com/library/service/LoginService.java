package com.library.service;

import com.library.bean.ReaderCard;
import com.library.dao.AdminDao;
import com.library.dao.ReaderCardDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private ReaderCardDao readerCardDao;
    @Autowired
    private AdminDao adminDao;

//    public boolean hasMatchReader(long readerId,String password){
//        return  readerCardDao.getIdMatchCount(readerId, password)>0;
//    }

    public boolean hasMatchReader(String email,String password){
        return  readerCardDao.getIdMatchCount(email, password)>0;
    }
    public String getAdminUsername(String email) {
        return adminDao.getUsername(email);
    }

//    public String getAdminEmail(String password) {
//        return adminDao.getUseremail(password);
//    }

    public ReaderCard findReaderCardByReaderId(long readerId){
        return readerCardDao.findReaderByReaderId(readerId);
    }

    public ReaderCard findReaderCardByEmail(String email){
        return readerCardDao.findReaderByEmail(email);
    }

    public boolean hasMatchAdmin(String email,String password){
        return adminDao.getMatchCount(email, password) >0;
    }

//    public boolean hasMatchAdmin(long adminId,String password){
//        return adminDao.getMatchCount(adminId, password) == 1;
//    }

    public boolean adminRePassword(long adminId, String newPassword){
        return adminDao.resetPassword(adminId,newPassword)>0;
    }
    public String getAdminPassword(long adminId){
        return adminDao.getPassword(adminId);
    }

    public boolean readerRePassword(long readerId, String newPassword) {
        return readerCardDao.resetPassword(readerId, newPassword) > 0;
    }

    public String getReaderPassword(long readerId) {
        return readerCardDao.getPassword(readerId);
    }


}
