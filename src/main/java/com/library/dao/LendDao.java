package com.library.dao;

import com.library.bean.Lend;
import com.library.bean.LendPlus;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class LendDao {

    @Resource
    private SqlSessionTemplate sqlSessionTemplate;

    private final static String NAMESPACE = "com.library.dao.LendDao.";

//    还书，在借书表里面写上归还时间，即当前系统时间
    public int returnBookOne(final long book_id, long reader_id) {
        Map<String, Object> map = new HashMap<>();
        map.put("book_id", book_id);
        map.put("reader_id", reader_id);
        return sqlSessionTemplate.update(NAMESPACE + "returnBookOne", map);
    }

//    还书，在图书表里面把所还书的数目加1
        public int returnBookTwo(final long book_id) {
        return sqlSessionTemplate.update(NAMESPACE + "returnBookTwo", book_id);
    }

    //借书，在借书表里面加一条记录
    public int lendBookOne(final long book_id, final long reader_id) {
        Map<String, Object> map = new HashMap<>();
        map.put("book_id", book_id);
        map.put("reader_id", reader_id);
        return sqlSessionTemplate.insert(NAMESPACE + "lendBookOne", map);
    }

    //借书，在图书表里面把所借书的数目减1
    public int lendBookTwo(final long book_id) {
        return sqlSessionTemplate.update(NAMESPACE + "lendBookTwo", book_id);
    }

    //管理员：展示所有借书记录
    public ArrayList<LendPlus> lendList() {
        List<LendPlus> result = sqlSessionTemplate.selectList(NAMESPACE + "lendList");
        return (ArrayList<LendPlus>) result;
    }

//    读者：展示自己的借书记录
    public ArrayList<LendPlus> myLendList(final long reader_id) {
        List<LendPlus> result = sqlSessionTemplate.selectList(NAMESPACE + "myLendList", reader_id);
        return (ArrayList<LendPlus>) result;
    }

    //删除借书记录，没还的不能删
    public int deleteLend(final long ser_num) {
        return sqlSessionTemplate.delete(NAMESPACE + "deleteLend", ser_num);
    }
}
