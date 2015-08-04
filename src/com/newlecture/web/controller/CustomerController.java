package com.newlecture.web.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.newlecture.web.dao.NoticeDao;
import com.newlecture.web.dao.NoticeFileDao;
import com.newlecture.web.vo.Notice;
import com.newlecture.web.vo.NoticeFile;

@Controller
@RequestMapping("/customer/*")
public class CustomerController {
	
	private NoticeDao noticeDao;
	private NoticeFileDao noticeFileDao;
	
	@Autowired
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}
	
	@Autowired
	public void setNoticeFileDao(NoticeFileDao noticeFileDao) {
		this.noticeFileDao = noticeFileDao;
	}



	@RequestMapping("notice")
	public String notice(Model model){
		//NoticeDao noticeDao = new MyBatisNoticeDao();
		List<Notice> list = noticeDao.getNotices();

		model.addAttribute("list", list);
		
		return "/WEB-INF/view/customer/notice.jsp";
	}
	
	@RequestMapping("noticeDetail")
	public String noticeDetail(String c, Model model){
		//NoticeDao noticeDao = new MyBatisNoticeDao();
		Notice n = noticeDao.getNotice(c);

		model.addAttribute("n", n);
		
		return "/WEB-INF/view/customer/noticeDetail.jsp";
	}
	
	@RequestMapping(value="noticeReg", method=RequestMethod.GET)
	public String noticeReg(){
		
		return "/WEB-INF/view/customer/noticeReg.jsp";
	}
	
	@RequestMapping(value="noticeReg", method=RequestMethod.POST)
	public String noticeReg(Notice n, MultipartFile file, Principal principal ,HttpServletRequest request, //SecurityContextHolder holder,
										SecurityContext context) throws IOException{
		
		
		
		if(request.isUserInRole("ROLE_ADMIN"))
		{
			
		}
		//holder.getContext();
		Context.getAuthentication().getAuthorities();
		Context.getAuthentication().isAuthenticated();
		
		n.setWriter(principal.getName());
		noticeDao.addNotice(n);
		String lastCode = noticeDao.getLastCode();
		
		if(!file.isEmpty())
		{
			//Part part = request.getPart("file");
			ServletContext application = request.getServletContext();
						
			String url = "/resource/customer/upload";
			String path = application.getRealPath(url);
			String temp = file.getOriginalFilename();//part.getSubmittedFileName();
			String fname = temp.substring(temp.lastIndexOf("\\")+1);
			String fpath = path + "\\" + fname;
			
			InputStream ins = file.getInputStream();//part.getInputStream();
			OutputStream outs = new FileOutputStream(fpath);
			
			byte[] 대야 = new byte[1024];
			int len = 0;
			
			while((len = ins.read(대야, 0, 1024)) >= 0)
				outs.write(대야, 0, len);
			
			outs.flush();
			outs.close();
			ins.close();
			
			NoticeFile noticeFile = new NoticeFile();
			noticeFile.setNoticeCode(lastCode);
			noticeFile.setName(fname);
			noticeFileDao.addNoticeFile(noticeFile);
		}
				
		return "redirect:notice";
	}
}
