package adressBook;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class adressBookDAO {

    private PreparedStatement stmt;
    private Connection con;
    private ResultSet rs;

    public adressBookDAO(){
        try {
            String db_name = "db";
            String db_url = "jdbc:mysql://localhost:3306/" + db_name;
            String db_id = "root";
            String db_pwd = "root";
            Class.forName("com.mysql.cj.jdbc.Driver");// 드라이버
            con = DriverManager.getConnection(db_url, db_id, db_pwd);
        }
        catch (Exception ex){
            ex.printStackTrace(); // 오류가 뭔지 출력
            System.out.println("db 연동 실패");
        }
    }

    public ArrayList<adressBook> getList(int nowPage, int recordNumPerPage, String searchWord){
        String SQL;
        if(searchWord.equals("")){
            SQL = "select * from adressBook order by no asc";
        }
        else{
            SQL = "select * from adressBook where name like '%" + searchWord + "%' order by no asc";
        }
        ArrayList<adressBook> list = new ArrayList<adressBook>();
        try {
            stmt = con.prepareStatement(SQL);
            rs = stmt.executeQuery();
            int count = 0;

            while (rs.next()){

                if (count >= (nowPage - 1) * recordNumPerPage && count < nowPage * recordNumPerPage){
                    adressBook ab = new adressBook();
                    ab.setNo(rs.getInt(1));
                    ab.setName(rs.getString(2));
                    ab.setTel(rs.getString(3));
                    ab.setMs(rs.getInt(4));
                    ab.setBirthday(rs.getString(5));
                    ab.setAdress(rs.getString(6));
                    list.add(ab);
                }
                count++;
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return list;
    }

    public int getTotalRecordCount(String searchWord){
        int columnCount = 0;
        String SQL;
        if(searchWord.equals("")){
            SQL = "select * from adressBook order by no asc";
        }
        else{
            SQL = "select * from adressBook where name like '%" + searchWord + "%' order by no asc";
        }

        try {
            stmt = con.prepareStatement(SQL, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); // 레코드 앞뒤로 옮기기 위함
            rs = stmt.executeQuery();
            rs.last();
            columnCount = rs.getRow(); // 레코드 개수 구하기
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return columnCount;
    }

    public int writeNew(String name, String tel, int ms, String adress, String birthday){
        String SQL = "insert into adressBook (name, tel, ms, adress, birthday) values(?, ?, ?, ?, ?)";
        try {
            stmt = con.prepareStatement(SQL);
            stmt.setString(1, name);
            stmt.setString(2, tel);
            stmt.setInt(3, ms);
            stmt.setString(4, adress);
            stmt.setString(5, birthday);
            stmt.executeUpdate();

            return 0; // 성공

        }catch (Exception e){
            e.printStackTrace();
        }
        return -1; // 실패
    }

    public adressBook findByNo(int no){
        String SQL = "select * from adressBook where no=" + no;
        adressBook adb = new adressBook();
        try {
            stmt = con.prepareStatement(SQL);
            rs = stmt.executeQuery();

            while (rs.next()) {
                adb.setNo(rs.getInt(1));
                adb.setName(rs.getString(2));
                adb.setTel(rs.getString(3));
                adb.setMs(rs.getInt(4));
                adb.setBirthday(rs.getString(5));
                adb.setAdress(rs.getString(6));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return adb;
    }

    public int updateAdressBook(int no, String name, String tel, int ms, String adress, String birthday){
        String SQL = "update adressBook set name=?, tel=?, ms=?, adress=?, birthday=? where no=?";
        try {
            stmt = con.prepareStatement(SQL);
            stmt.setString(1, name);
            stmt.setString(2, tel);
            stmt.setInt(3, ms);
            stmt.setString(4, adress);
            stmt.setString(5, birthday);
            stmt.setInt(6, no);
            stmt.executeUpdate();

            return 0; // 성공
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1; // 실패
    }

    public int deleteAdressBook(int no){
        String SQL = "delete from adressBook where no=" + no;
        try {
            stmt = con.prepareStatement(SQL);
            stmt.executeUpdate();

            return 0; // 성공
        } catch (Exception e){
            e.printStackTrace();
        }
        return -1; // 실패
    }

}
