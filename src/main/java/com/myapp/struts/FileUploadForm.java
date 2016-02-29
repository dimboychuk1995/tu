/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.struts;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;
import ua.ifr.oe.tc.list.SQLUtils;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author us8610
 */
public class FileUploadForm extends org.apache.struts.action.ActionForm {

    private FormFile file;
    private String db;
    private String db_name;
    private String tu_id;

    public String getTu_id() {
        return tu_id;
    }

    public void setTu_id(String tu_id) {
        this.tu_id = tu_id;
    }

    public FormFile getFile() {
        return file;
    }

    public void setFile(FormFile file) {
        this.file = file;
    }

    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();

        if (getFile().getFileSize() == 0) {
            errors.add("common.file.err",
                    new ActionMessage("error.common.file.required"));
            return errors;
        }
        String mime = getFile().getContentType();
        if (!("application/msword".equals(mime)) && !("application/pdf".equals(mime)) && !("image/jpeg".equals(mime)) && !("image/jpg".equals(mime))) {
            errors.add("common.file.err.ext",
                    new ActionMessage("error.common.file.textfile.only"));
            return errors;

        }
        File newFile = new File("\\\\10.93.104.55\\TUFiles\\", file.getFileName().replaceAll("\\s", ""));
        if (newFile.exists()) {
            errors.add("common.file.exists",
                    new ActionMessage("error.common.file.textfile.exists"));
            return errors;
        }

        //file size cant larger than 25mb
        //System.out.println(getFile().getFileSize());
        if (getFile().getFileSize() > 100214400) { //~100mb
            errors.add("common.file.err.size",
                    new ActionMessage("error.common.file.size.limit", 102400));
            return errors;
        }

        return errors;
    }

    public void init(HttpServletRequest request) {
        HttpSession ses = request.getSession();
        if (ses.getAttribute("db_name")!=null) {
            db = (String) ses.getAttribute("db_name");
        } else {
            db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
        }
        this.db_name = "java:comp/env/jdbc/" + db;

    }

    public void add(String file_name, String full_name, String comment) {
        InitialContext ic = null;
        DataSource ds = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        try {
            ic = new InitialContext();
            ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String SQL = "INSERT INTO [Files] ([tu_id],[file_name],[full_name],[comment])"
                    + " VALUES('" + tu_id + "','"
                    + file_name.replace("'", "''") + "','"
                    + full_name.replace("'", "''") + "','"
                    + comment + "')";
            pstmt = Conn.prepareStatement(SQL);
            pstmt.execute();
//            pstmt.close();
//            Conn.close();
//            ic.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void delete(String file_name, String path) {
        InitialContext ic = null;
        DataSource ds = null;
        Connection Conn = null;
        PreparedStatement pstmt = null;
        try {
            ic = new InitialContext();
            ds = (DataSource) ic.lookup(db_name);
            Conn = ds.getConnection();
            String SQL = "DELETE FROM [TUWebTEST].[dbo].[Files] WHERE [file_name]='" + file_name + "'";
            File file = new File(path);
            file.delete();
            pstmt = Conn.prepareStatement(SQL);
            pstmt.execute();
//            pstmt.close();
//            Conn.close();
//            ic.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
        } finally {
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(Conn);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }
    }
}
