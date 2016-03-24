/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package detalview.action;

import com.myapp.struts.FileUploadForm;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;
import ua.ifr.oe.tc.list.MailSender;
import ua.ifr.oe.tc.list.SQLUtils;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class FileUploadAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        FileUploadForm fileUploadForm = (FileUploadForm) form;
        fileUploadForm.init(request);
        String comment = request.getParameter("f_desc");
        String tu_id = request.getParameter("tu_id");
        FormFile file = fileUploadForm.getFile();
        String dtime = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
        String filePath = "http://10.93.104.55/FileManager/TUFiles/";
        String filePath1 = "\\\\Obl-devel\\TUFiles\\";
        String mailSmtpHost = "10.93.1.63";
        String mailTo = "Dmytro.Boychuk@oe.if.ua";
        String mailFrom = "Dmytro.Boychuk@oe.if.ua";
        String mailSubject = getPersonalData(tu_id, request);
        String mailText = "Mesage about add a new file to TU";
        String connName = (String) request.getParameter("rem");
        String engineer = request.getParameter("engineer");
        Map<String,String> hm = new HashMap();
        hm.put("1", "liubov.kutsa@oe.if.ua");
        hm.put("2", "oleh.kushyna@oe.if.ua");
        hm.put("3", "viktor.yatskovyi@oe.if.ua");
        hm.put("4", "oksana.solonychna@oe.if.ua");
        hm.put("5", "Vasyl.Ostap'yuk@oe.if.ua");
        File folder = new File(filePath1);
        if (!folder.exists()) {
            folder.mkdir();
        }
        String fileName = dtime + file.getFileName().replaceAll("\\s", "");
            if (!("").equals(fileName)) {
                File newFile = new File(filePath1, fileName);
                if (!newFile.exists()) {
                    FileOutputStream fos = new FileOutputStream(newFile);
                    fos.write(file.getFileData());
                    fos.flush();
                    fos.close();
                }
                String full_path = filePath + fileName;
                fileUploadForm.add(fileName, full_path, comment);
                if (null != engineer) {
                mailTo = hm.get(engineer);
                MailSender.sendEmail(mailTo, mailFrom, mailSubject, mailText, mailSmtpHost);
            }
        }
        return mapping.findForward("success");
    }

    public String getPersonalData(String tu_id, HttpServletRequest request) {
        String data = "";
        InitialContext ic = null;
        DataSource ds = null;
        Connection c = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            HttpSession ses = request.getSession();
            String db = (String) ses.getAttribute("db_name");
            ic = new InitialContext();
            ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
            c = ds.getConnection();
            String sql = "SELECT tv.number,r.rem_name "
                       + " FROM [TC_V2] tv "
                       + " LEFT JOIN TUWeb.dbo.rem r ON tv.department_id = r.rem_id "
                       + " WHERE tv.id='" + tu_id + "'";
            pstmt = c.prepareStatement(sql);
            rs = pstmt.executeQuery();
            rs.next();
            data = rs.getString("rem_name") + " РЕМ, номер ТУ " + rs.getString("number");
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } finally {
            try {
                SQLUtils.closeQuietly(rs);
                SQLUtils.closeQuietly(pstmt);
                SQLUtils.closeQuietly(c);
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }
        return "Завантажено новий файл:" + data;
    }
}