/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ua.ifr.oe.tu.ajax;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import ua.ifr.oe.tc.list.SQLUtils;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author us8610
 */
public class AppealsImport extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        Connection c = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        InitialContext ic = null;
        String ClientKind = new String();
        String f_nm = new String();
        String s_nm = new String();
        String l_nm = new String();
        String pas_ser = new String();
        String pas_no = new String();
        String pas_vud = new String();
        String ident_no = new String();
        String tel = new String();
        String mob_tel = new String();
        String acc_no = new String();//
        String jur_nm = new String();
        String edrpu = new String();
        String roz_rah = new String();
        String mfo = new String();//
        String ipn = new String();//
        String jur_pip_f = new String();
        String jur_pip_s = new String();
        String jur_pip_l = new String();
        String license = new String();
        String phone = new String();
        String obj_name = new String();
        String jur_adr = new String();
        String phjur_adr = new String();
        String phiz_adr = new String();
        String phiz_adr_o = new String();
        String phone_j = new String();
        String requestDate = new String();
        String num_zver = request.getParameter("num_zv");
        String rem_id = request.getParameter("rem_id");
        String db = "PR" + rem_id + "_MPP";
        try {
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
            String SQL = ""
                    + "SELECT r.number, "
                    + "       r.ContactPerson, "
                    + "       r.ContactPhone, "
                    + "       c.ClientKind, "
                    + "       isnull(c2.name,'')        AS JurName, "
                    + "       isnull(c2.EDRPOU,'') as EDRPOU, "
                    + "       isnull(JuridicalObjectName,'') as JuridicalObjectName, "
                    + "       isnull(JuridicalContractNumber,'') as JuridicalContractNumber, "
                    + "       isnull(DirectorFirstName,'') as DirectorFirstName, "
                    + "       isnull(DirectorLastName,'') as DirectorLastName, "
                    + "       isnull(DirectorMiddleName,'') as DirectorMiddleName, "
                    + "       isnull(Phone,'') as Phone, "
                    + "       isnull(a.FullAddress,'')  AS JuridicalAddress, "
                    + "       isnull(a.Building,'')     AS JurBuilding, "
                    + "       isnull(a.Apartment,'')    AS jurAppartment, "
                    + "       isnull(c3.Name,'')        AS JurCityName, "
                    + "       isnull(s.Name,'')         AS JurStreetName, "
                    + "       isnull(c2.Basis,'') as Basis, "
                    + "       isnull(c2.AccountNumber,'') as AccountNumber, "
                    + "       isnull(c2.BankName,'') as BankName, "
                    + "       isnull(c2.CertificateNumber,'') as CertificateNumber, "
                    + "       isnull(a2.FullAddress,'') AS PhJuridicaladdress, "
                    + "       isnull(a2.Building,'')    AS PHJurBuilding, "
                    + "       isnull(a2.Apartment,'')   AS PHjurAppartment, "
                    + "       isnull(c4.Name,'')        AS PHJurCityName, "
                    + "       isnull(s2.Name,'')        AS PHJurStreetName, "
                    + "       isnull(pp.FirstName,'') as FirstName, "
                    + "       pp.SecondName, "
                    + "       pp.LastName, "
                    + "       isnull(pp.PassportSeries,'') as PassportSeries, "
                    + "       isnull(pp.PassportNumber,'') as PassportNumber, "
                    + "       isnull(pp.PassportGiven,'') as PassportGiven, "
                    + "       isnull(pp.IdentificationCode,'') as IdentificationCode, "
                    + "       isnull(pp.PhoneNumber,'') as PhoneNumber, "
                    + "       isnull(pp.MobilePhoneNumber,'') as MobilePhoneNumber, "
                    + "       isnull(pp.UtilityAccountNumber,'') as UtilityAccountNumber, "
                    + "       a3.FullAddress AS PhisicalFullAddress, "
                    + "       a3.Apartment   AS PhisicalApartment, "
                    + "       isnull(a3.Building,'')    AS PhisicalBuilding, "
                    + "       c5.Name        AS PhisicalCityName, "
                    + "       isnull(s3.Name,'')        AS PhisicalStreetName, "
                    + "       c6.Name        AS PhisicalCityName1, "
                    + "       isnull(s4.Name,'')        AS PhisicalStreetName1, "
                    + "       a4.FullAddress AS PhisicalFullAddress1, "
                    + "       isnull(a4.Apartment,'')   AS PhisicalApartment1, "
                    + "       isnull(a4.Building,'')    AS PhisicalBuilding1, "
                    + "       isnull(convert(varchar,r.RequestDate,104),'') as  RequestDate"
                    + " FROM   Request.Request AS r "
                    + "       JOIN Request.Client AS c "
                    + "         ON r.ClientId = c.ClientId "
                    + "       LEFT JOIN Request.Contractor AS c2 "
                    + "              ON c.ClientId = c2.ClientId "
                    + "       LEFT JOIN MppDictionary.Address AS a "
                    + "              ON c2.JuridicalAddressId = a.AddressId "
                    + "       LEFT JOIN MppDictionary.Address AS a2 "
                    + "              ON c2.PhysicalAddressId = a2.AddressId "
                    + "       LEFT JOIN Organization.City AS c3 "
                    + "              ON a.CityId = c3.CityId "
                    + "       LEFT JOIN Organization.City AS c4 "
                    + "              ON a2.CityId = c4.CityId "
                    + "       LEFT JOIN Organization.Street AS s "
                    + "              ON a.StreetId = s.StreetId "
                    + "       LEFT JOIN Organization.Street AS s2 "
                    + "              ON a2.StreetId = s2.StreetId "
                    + "       LEFT JOIN Request.PhysicalPerson AS pp "
                    + "              ON c.ClientId = pp.ClientId "
                    + "       LEFT JOIN MppDictionary.Address AS a3 "
                    + "              ON pp.AddressId = a3.AddressId "
                    + "       LEFT JOIN MppDictionary.Address AS a4 "
                    + "              ON pp.PhysicalAddressId = a4.AddressId "
                    + "       LEFT JOIN Organization.City AS c5 "
                    + "              ON a3.CityId = c5.CityId "
                    + "       LEFT JOIN Organization.City AS c6 "
                    + "              ON a4.CityId = c6.CityId "
                    + "       LEFT JOIN Organization.Street AS s3 "
                    + "              ON a3.StreetId = s3.StreetId "
                    + "       LEFT JOIN Organization.Street AS s4 "
                    + "              ON a4.StreetId = s4.StreetId "
                    + "WHERE  r.Number = ?";
            c = ds.getConnection();
            pstmt = c.prepareStatement(SQL);
            pstmt.setString(1, num_zver);
            System.out.println(SQL + " " + num_zver);
            rs = pstmt.executeQuery();
            if (!rs.next()) {
                throw new SQLException();
            } else {
                do {
                    ClientKind = rs.getString("ClientKind");
                    f_nm = rs.getString("FirstName");
                    s_nm = rs.getString("SecondName");
                    l_nm = rs.getString("LastName");
                    pas_ser = rs.getString("PassportSeries");
                    pas_no = rs.getString("PassportNumber");
                    pas_vud = rs.getString("PassportGiven");
                    ident_no = rs.getString("IdentificationCode");
                    tel = rs.getString("PhoneNumber");
                    mob_tel = rs.getString("MobilePhoneNumber");
                    acc_no = rs.getString("UtilityAccountNumber");

                    jur_nm = rs.getString("JurName");
                    edrpu = rs.getString("EDRPOU");
                    roz_rah = rs.getString("AccountNumber");
                    mfo = rs.getString("BankName");
                    jur_pip_f = rs.getString("DirectorLastName");
                    jur_pip_s = rs.getString("DirectorFirstName");
                    jur_pip_l = rs.getString("DirectorMiddleName");
                    obj_name = rs.getString("JuridicalObjectName");
                    jur_adr = rs.getString("JurStreetName") + ", " + rs.getString("JurBuilding") + ", " + rs.getString("jurAppartment");
                    phjur_adr = rs.getString("PHJurStreetName") + ", " + rs.getString("PHJurBuilding") + ", " + rs.getString("PHjurAppartment");
                    phiz_adr_o = rs.getString("PhisicalStreetName1") + ", " + rs.getString("PhisicalBuilding1") + ", " + rs.getString("PhisicalApartment1");
                    phiz_adr = rs.getString("PhisicalStreetName") + ", " + rs.getString("PhisicalBuilding") + ", " + rs.getString("PhisicalApartment");
                    phone_j = rs.getString("Phone");
                    requestDate = rs.getString("RequestDate");
                } while (rs.next());
            }
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("ClientKind", ClientKind);
            jsonObject.addProperty("f_nm", f_nm);
            jsonObject.addProperty("s_nm", s_nm);
            jsonObject.addProperty("l_nm", l_nm);
            jsonObject.addProperty("pas_ser", pas_ser);
            jsonObject.addProperty("pas_no", pas_no);
            jsonObject.addProperty("pas_vud", pas_vud);
            jsonObject.addProperty("ident_no", ident_no);
            jsonObject.addProperty("tel", tel);
            jsonObject.addProperty("mob_tel", mob_tel);
            jsonObject.addProperty("acc_no", acc_no);
            jsonObject.addProperty("roz_rah", roz_rah);
            jsonObject.addProperty("jur_nm", jur_nm);
            jsonObject.addProperty("edrpu", edrpu);
            jsonObject.addProperty("mfo", mfo);
            jsonObject.addProperty("jur_pip_f", jur_pip_f);
            jsonObject.addProperty("jur_pip_s", jur_pip_s);
            jsonObject.addProperty("jur_pip_l", jur_pip_l);
            jsonObject.addProperty("obj_name", obj_name);
            jsonObject.addProperty("phjur_adr", phjur_adr);
            jsonObject.addProperty("jur_adr", jur_adr);
            jsonObject.addProperty("phiz_adr", phiz_adr);
            jsonObject.addProperty("phiz_adr_o", phiz_adr_o);
            jsonObject.addProperty("phone_j", phone_j);
            jsonObject.addProperty("requestDate", requestDate);
            String json = new Gson().toJson(jsonObject);
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
        } finally {
            SQLUtils.closeQuietly(rs);
            SQLUtils.closeQuietly(pstmt);
            SQLUtils.closeQuietly(c);
            try {
                ic.close();
            } catch (NamingException ex) {
                ex.printStackTrace();
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
