package Model;

/**
 * Created by us9522 on 01.11.2016.
 */
public class User {

    private int id;
    private String name;
    private String pass;
    private String PIP;
    private int tab_no;
    private int idRem;
    private int role;
    private String tel_number;
    private int permission;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getPIP() {
        return PIP;
    }

    public void setPIP(String PIP) {
        this.PIP = PIP;
    }

    public int getTab_no() {
        return tab_no;
    }

    public void setTab_no(int tab_no) {
        this.tab_no = tab_no;
    }

    public int getIdRem() {
        return idRem;
    }

    public void setIdRem(int idRem) {
        this.idRem = idRem;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getTel_number() {
        return tel_number;
    }

    public void setTel_number(String tel_number) {
        this.tel_number = tel_number;
    }

    public int getPermission() {
        return permission;
    }

    public void setPermission(int permission) {
        this.permission = permission;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (id != user.id) return false;
        if (idRem != user.idRem) return false;
        if (permission != user.permission) return false;
        if (role != user.role) return false;
        if (tab_no != user.tab_no) return false;
        if (PIP != null ? !PIP.equals(user.PIP) : user.PIP != null) return false;
        if (name != null ? !name.equals(user.name) : user.name != null) return false;
        if (pass != null ? !pass.equals(user.pass) : user.pass != null) return false;
        if (tel_number != null ? !tel_number.equals(user.tel_number) : user.tel_number != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (pass != null ? pass.hashCode() : 0);
        result = 31 * result + (PIP != null ? PIP.hashCode() : 0);
        result = 31 * result + tab_no;
        result = 31 * result + idRem;
        result = 31 * result + role;
        result = 31 * result + (tel_number != null ? tel_number.hashCode() : 0);
        result = 31 * result + permission;
        return result;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", pass='" + pass + '\'' +
                ", PIP='" + PIP + '\'' +
                ", tab_no=" + tab_no +
                ", idRem=" + idRem +
                ", role=" + role +
                ", tel_number='" + tel_number + '\'' +
                ", permission=" + permission +
                '}';
    }
}
