package oblenergo.users;

import Model.User;
import com.myapp.struts.DetalViewActionForm;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Created by us9522 on 01.11.2016.
 */
@ManagedBean
@ApplicationScoped
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private String db_name = "java:comp/env/jdbc/TUWeb";

    InitialContext ic = null;
    Connection connection = null;
    Statement stmt;
    ResultSet rs = null;
    DetalViewActionForm detailview;

//    public void initCustomer(HttpServletRequest request){
//        HttpSession session = request.getSession();
//        this.db_name = "java:comp/env/jdbc/" + session.getAttribute("db_name");
//        System.out.println("db_name = " + db_name);
//    }


    private ArrayList<User> userList = new ArrayList<User>();

    private ArrayList<User> getUsers(String qry) throws SQLException, NamingException {

            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(db_name);
            connection = ds.getConnection();
            stmt = connection.createStatement();
            rs = stmt.executeQuery(qry);


            while (rs.next()){
                User user = new User();
                user.setId(rs.getInt("USER_ID"));
                user.setName(rs.getString("USER_NAME"));
                user.setPass(rs.getString("USER_PASS"));
                user.setPIP(rs.getString("USER_PIP"));
                user.setTab_no(rs.getInt("USER_TAB_NO"));
                user.setIdRem(rs.getInt("USER_ID_REM"));
                user.setRole(rs.getInt("USER_ROLE"));
                user.setTel_number(rs.getString("TEL_NUMBER"));
                user.setPermission(rs.getInt("USER_PERMISIONS"));
                userList.add(user);
            }

        return userList;
    }

    public ArrayList<User> AllUsers() throws SQLException, NamingException {
//        Integer id = Integer.valueOf(request.getParameter("USER_ID"));
//        String name = request.getParameter("USER_NAME");
//        String pass = request.getParameter("USER_PASS");
//        String PIP = request.getParameter("USER_PIP");
//        Integer tab_no = Integer.valueOf(request.getParameter("USER_TAB_NO"));
//        Integer idRem = Integer.valueOf(request.getParameter("USER_ID_REM   "));
//        Integer role = Integer.valueOf(request.getParameter("USER_ROLE"));
//        String tel_number = request.getParameter("TEL_NUMBER");
//        Integer permission = Integer.valueOf(request.getParameter("USER_PERMISIONS"));

        String allUsers = "SELECT \n" +
                "[USER_ID] \n" +
                ",[USER_NAME] \n" +
                ",[USER_PASS] \n" +
                ",[USER_PIP] \n" +
                ",[USER_TAB_NO] \n" +
                ",[USER_ID_REM] \n" +
                ",[USER_ROLE] \n" +
                ",[TEL_NUMBER] \n" +
                ",[USER_PERMISIONS] \n" +
                "FROM [TUWeb].[dbo].[TC_USER]";

        return getUsers(allUsers);
    }

    protected void deleteUser(HttpServletRequest request, HttpServletResponse response) throws NamingException, SQLException, IOException {
        Integer id = Integer.valueOf(request.getParameter("USER_ID"));

        ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup(db_name);
        connection = ds.getConnection();
        stmt = connection.createStatement();

        String sql = "DELETE FROM [TUWeb].[dbo].[TC_USER] \n" +
                "WHERE USER_ID = " + id;

        stmt.executeUpdate(sql);
        response.sendRedirect("users/users.jsp");

        connection.close();
        stmt.close();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader( "Content-disposition", "inline; filename=ALVList.html" );
        response.setHeader( "Cache-control", "" );
        response.setHeader( "Pragma", "" );
        request.setCharacterEncoding("UTF-8");
        super.service(request, response); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(request.getParameterMap().size() == 1){
            try {
                deleteUser(request, response);
            } catch (NamingException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(request.getParameterMap().size() == 1){
            try {
                deleteUser(request, response);
            } catch (NamingException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
