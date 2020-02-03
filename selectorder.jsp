<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <title>connect mysql</title>
    </head>
<body>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
    <%
    try{
        Class.forName("org.gjt.mm.mysql.Driver");
        Connection mycon = DriverManager.getConnection("jdbc:mysql://localhost:3306/abc_company?user=root&password=root");
        Statement stmt = mycon.createStatement();
        ResultSet myresult = stmt.executeQuery("SELECT order_tbl.oid,order_tbl.discount,ROUND(order_tbl.qty*product_tbl.unitprice-order_tbl.qty*product_tbl.unitprice/100*order_tbl.discount),(SELECT SUM(order_tbl.qty*product_tbl.unitprice-order_tbl.qty*product_tbl.unitprice/100*order_tbl.discount) FROM order_tbl,product_tbl,customer_tbl,employee_tbl WHERE order_tbl.pid=product_tbl.pid AND order_tbl.cid=customer_tbl.cid AND order_tbl.eid=employee_tbl.eid) , order_tbl.pid, product_tbl.pname, product_tbl.unitprice, order_tbl.qty, customer_tbl.cname,employee_tbl.ename FROM order_tbl,product_tbl,customer_tbl,employee_tbl WHERE order_tbl.pid=product_tbl.pid and order_tbl.cid=customer_tbl.cid and order_tbl.eid=employee_tbl.eid");
        double sum=0;
        if(myresult !=null){           
            out.println("<center> Show data from tables order_tbl <br><br>");
            out.println("<table aling=center border=1 cellpadding=5>");
            out.println("<tr><td>รหัสใบสั่งซื้อ</td><td>รหัสสินค้า</td><td>ชื ่อสินค้า</td><td>จำนวน</td><td>ราคา/หน่วย</td><td>ส่วนลด%</td><td>ราคารวมหักส่วนลด</td></tr>");
            while (myresult.next()){
            out.println("<tr><td>"+myresult.getString("order_tbl.oid")+"</td>");
            out.println("<td>"+myresult.getString("order_tbl.pid")+"</td>");
            out.println("<td>"+myresult.getString("product_tbl.pname")+"</td>");
            out.println("<td>"+myresult.getString("order_tbl.qty")+"</td>");
            out.println("<td>"+myresult.getString("product_tbl.unitprice")+"</td>");
            out.println("<td>"+myresult.getString("order_tbl.discount")+"</td>");
            out.println("<td>"+myresult.getString("ROUND(order_tbl.qty*product_tbl.unitprice-order_tbl.qty*product_tbl.unitprice/100*order_tbl.discount)")+"</td>"); 
          // sum=Double.parseDouble(myresult.getString("(SELECT SUM(order_tbl.qty*product_tbl.unitprice-order_tbl.qty*product_tbl.unitprice/100*order_tbl.discount) FROM order_tbl,product_tbl,customer_tbl,employee_tbl WHERE order_tbl.pid=product_tbl.pid AND order_tbl.cid=customer_tbl.cid AND order_tbl.eid=employee_tbl.eid)"));
          //  out.println("<td>"+myresult.getString("SELECT SUM(order_tbl.qty*product_tbl.unitprice-order_tbl.qty*product_tbl.unitprice/100*order_tbl.discount) FROM order_tbl,product_tbl,customer_tbl,employee_tbl WHERE order_tbl.pid=product_tbl.pid AND order_tbl.cid=customer_tbl.cid AND order_tbl.eid=employee_tbl.eid)")+"</td></tr>");          
          //   out.println("<tr><td></td></tr>");
            } 
          //  out.println("<td>"+myresult.getString("ROUND(order_tbl.qty*product_tbl.unitprice-order_tbl.qty*product_tbl.unitprice/100*order_tbl.discount)")+"</td></tr>");
           // out.println("<tr><td></td><td></td><td></td><td></td><td>ยอดสั้งซื้อทั้งหมด</td><td>3520814.37500000</td><td>บาท</td></tr>");
        }
         out.println("</table></center>");
         stmt.close();
         mycon.close();
        
    }
   
    
    catch(ClassNotFoundException e){
        out.println("Not found driver");
    }
    catch(SQLException e){
        out.println("Not call");
    }
    %>
</body>   

</html>