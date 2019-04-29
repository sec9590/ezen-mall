package admin;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Servlet implementation class FileController
 */
@WebServlet("/control/fileController")
public class FileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = LoggerFactory.getLogger(FileController.class);
 
    public FileController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, ServletException, IOException {
		FileInputStream fis = null;
		BufferedOutputStream bos = null;
		BufferedInputStream bis = null;
		int length;
		
		AdminDAO aDao = new AdminDAO();
		String sb = aDao.prepareDownload();
		String client = request.getHeader("User-Agent");
		// ���� �ٿ�ε� ��� ����
		response.reset() ;
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description", "JSP Generated Data");
		
		if(client.indexOf("MSIE") != -1) {		// Internet Explorer
			response.setHeader ("Content-Disposition", "attachment; filename=Whole Sales.csv");
		} else {			// IE �̿�
			response.setHeader("Content-Disposition", "attachment; filename=\"Whole Sales.csv\"");
			response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
		} 
		File file = new File("D:/Workspace/Temp/Whole Sales.csv");
		response.setHeader ("Content-Length", "" + file.length());
		try {
			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] bytes = new byte[1024];
			while ((length = bis.read(bytes)) != -1) {
				LOG.debug("Length = " + length);
				bos.write(bytes, 0, length);
			}
			bos.flush();
			bos.close();
			bis.close();
			fis.close();
		} catch (IllegalStateException e1) {
			LOG.info("doGet(): IllegalStateException Error");
		} catch (Exception e) {
			LOG.debug(e.getMessage());
		}
		LOG.trace("FileController.class: After try");	
		/*PrintWriter out = response.getWriter();
		out.write("<script>alert('�ٿ�ε� �Ϸ�');history.go(-1);</script>");
		bos.flush();*/
		/*RequestDispatcher rd = request.getRequestDispatcher("../control/adminControl.jsp?action=download");
		rd.forward(request, response);*/
		return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
