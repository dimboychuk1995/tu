<%-- 
    Document   : appeals
    Created on : Feb 20, 2013, 10:52:47 AM
    Author     : us8610
--%>

<%@page import="ua.ifr.oe.tc.list.SQLUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/json.tld" prefix="json" %>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.sql.DataSource,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1

    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
    //String ps_id = request.getParameter("ps_id");
    Connection c = null;
    ResultSet rs = null;
    PreparedStatement pstmt = null;
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
    String rem_id;
    String num_zver = request.getParameter("num_zv");
    HttpSession ses = request.getSession();
    rem_id = ua.ifr.oe.tc.list.MyCoocie.getCoocie("rem_id", request);
    String db = "PR" + rem_id + "_Mpp";
    InitialContext ic = new InitialContext();
    DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/" + db);
    try {
        c = ds.getConnection();
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
                + "WHERE  r.Number =" + num_zver;
        pstmt = c.prepareStatement(SQL);
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
    } catch (Exception e) {
        response.setStatus(response.SC_INTERNAL_SERVER_ERROR);

    } finally {
        SQLUtils.closeQuietly(rs);
        SQLUtils.closeQuietly(pstmt);
        SQLUtils.closeQuietly(c);
        ic.close();
    }

    pageContext.setAttribute("ClientKind", ClientKind);
    pageContext.setAttribute("f_nm", f_nm);
    pageContext.setAttribute("s_nm", s_nm);
    pageContext.setAttribute("l_nm", l_nm);
    pageContext.setAttribute("pas_ser", pas_ser);
    pageContext.setAttribute("pas_no", pas_no);
    pageContext.setAttribute("pas_vud", pas_vud);
    pageContext.setAttribute("ident_no", ident_no);
    pageContext.setAttribute("tel", tel);
    pageContext.setAttribute("mob_tel", mob_tel);
    pageContext.setAttribute("acc_no", acc_no);
    pageContext.setAttribute("jur_nm", jur_nm);
    pageContext.setAttribute("edrpu", edrpu);
    pageContext.setAttribute("mfo", mfo);
    pageContext.setAttribute("roz_rah", roz_rah);
    pageContext.setAttribute("jur_pip_f", jur_pip_f);
    pageContext.setAttribute("jur_pip_s", jur_pip_s);
    pageContext.setAttribute("jur_pip_l", jur_pip_l);
    pageContext.setAttribute("obj_name", obj_name);
    pageContext.setAttribute("jur_adr", jur_adr);
    pageContext.setAttribute("phjur_adr", phjur_adr);
    pageContext.setAttribute("phiz_adr", phiz_adr);
    pageContext.setAttribute("phiz_adr_o", phiz_adr_o);
    pageContext.setAttribute("phone_j", phone_j);
    pageContext.setAttribute("requestDate", requestDate);
%>
<json:object >
    <json:property name="ClientKind" > ${ClientKind}</json:property>
    <json:property name="f_nm" > ${f_nm}</json:property>
    <json:property name="s_nm" > ${s_nm}</json:property>
    <json:property name="l_nm" > ${l_nm}</json:property>
    <json:property name="pas_ser" > ${pas_ser}</json:property>
    <json:property name="pas_no" > ${pas_no}</json:property>
    <json:property name="pas_vud" > ${pas_vud}</json:property>
    <json:property name="ident_no" > ${ident_no}</json:property>
    <json:property name="tel" > ${tel}</json:property>
    <json:property name="mob_tel" > ${mob_tel}</json:property>
    <json:property name="acc_no" > ${acc_no}</json:property>
    <json:property name="roz_rah" > ${roz_rah}</json:property>
    <json:property name="jur_nm" > ${jur_nm}</json:property>
    <json:property name="edrpu" > ${edrpu}</json:property>
    <json:property name="mfo" > ${mfo}</json:property>
    <json:property name="jur_pip_f" > ${jur_pip_f}</json:property>
    <json:property name="jur_pip_s" > ${jur_pip_s}</json:property>
    <json:property name="jur_pip_l" > ${jur_pip_l}</json:property>
    <json:property name="obj_name" > ${obj_name}</json:property>
    <json:property name="phjur_adr" > ${phjur_adr}</json:property>
    <json:property name="jur_adr" > ${jur_adr}</json:property>
    <json:property name="phiz_adr" > ${phiz_adr}</json:property>
    <json:property name="phiz_adr_o" > ${phiz_adr_o}</json:property>
    <json:property name="phone_j" > ${phone_j}</json:property>
    <json:property name="requestDate">${requestDate}</json:property>    
</json:object>
