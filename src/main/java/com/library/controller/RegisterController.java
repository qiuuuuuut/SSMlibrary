package com.library.controller;

import com.library.bean.Admin;
import com.library.bean.ReaderCard;
import com.library.bean.ReaderInfo;
import com.library.dao.ReaderCardDao;
import com.library.service.ReaderCardService;
import com.library.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

@Controller
public class RegisterController {
    @Autowired
    private ReaderCardService readerCardService;
    @Autowired
    private ReaderInfoService readerInfoService;

    @RequestMapping(value = "/api/registerCheck", method = RequestMethod.POST)
    @ResponseBody
    public Object registerCheck(HttpServletRequest request) {
        String username = request.getParameter("username");
        String passwd = request.getParameter("passwd");
        String yanzhenma=request.getParameter("yanzhenma");
        String sex=request.getParameter("sex");
        String birth=request.getParameter("birth");
        String address=request.getParameter("address");
        String phone=request.getParameter("phone");
        HashMap<String, String> res = new HashMap<>();
        //判断验证码是否正确（验证码已经放入session）
        HttpSession session = request.getSession();
        String realCode = (String)session.getAttribute("VerifyCode");
//        System.out.println(realCode);
//        System.out.println(yanzhenma);
        if(!realCode.toLowerCase().equals(yanzhenma.toLowerCase()))
        {

            res.put("stateCode", "2");
            res.put("msg", "验证码错误！");
            return res;
        }
        Date date = new Date();
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            date = df.parse(birth);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        ReaderInfo readerInfo = new ReaderInfo();
        ReaderCard readerCard = new ReaderCard();

        readerCard.setName(username);
        readerCard.setPassword(passwd);

        readerInfo.setName(username);
        readerInfo.setAddress(address);
        readerInfo.setSex(sex);
        readerInfo.setBirth(date);
        readerInfo.setPhone(phone);

        long readerId = readerInfoService.addReaderInfo(readerInfo);
        readerInfo.setReaderId(readerId);

        //4.判断注册成功与否
        if(readerId > 0 && readerCardService.addReaderCard(readerInfo, passwd)){
            res.put("stateCode", "1");
            res.put("msg", "注册成功！");
        }else {
            res.put("stateCode", "0");
            res.put("msg", "注册失败！");
        }

        return res;
    }

    @RequestMapping("/register.html")
    public ModelAndView toAdminMain(HttpServletResponse response) {
        return new ModelAndView("register");
    }

}
