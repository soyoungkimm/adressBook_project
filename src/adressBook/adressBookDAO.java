package adressBook;

import java.sql.*;
import java.util.ArrayList;

public class adressBookDAO {

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

    public ArrayList<adressBook> getList(int nowPage, int recordNumPerPage){
        String SQL = "select * from adressBook order by no asc";
        ArrayList<adressBook> list = new ArrayList<adressBook>();
        try {
            PreparedStatement stmt = con.prepareStatement(SQL);
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
                    ab.setJuso(rs.getString(6));
                    list.add(ab);
                }
                count++;
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return list;
    }

    public int getTotalRecordCount(){
        int columnCount = 0;
        String SQL = "select * from adressBook order by no asc";
        try {
            PreparedStatement stmt = con.prepareStatement(SQL, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE); // 레코드 앞뒤로 옮기기 위함
            rs = stmt.executeQuery();
            rs.last();
            columnCount = rs.getRow(); // 레코드 개수 구하기
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
        return columnCount;
    }

}
