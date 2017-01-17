package oe.tu.excel;

import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.*;
import jxl.format.VerticalAlignment;
import jxl.write.*;
import jxl.write.Number;
import ua.ifr.oe.tc.list.SQLUtils;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author us8610
 */
public class
        ExportAllRemsXLS extends HttpServlet {

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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection c = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        InitialContext ic = null;
        HttpSession ses = request.getSession();
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition",
                    "attachment; filename=all_rem_export.xls");

            String db = new String();
            if (ses.getAttribute("db_name") != null) {
                db = (String) ses.getAttribute("db_name");
            } else {
                db = ua.ifr.oe.tc.list.MyCoocie.getCoocie("db_name", request);
            }
            ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TUWeb190");
            c = ds.getConnection();
            pstmt = c.prepareStatement("{call dbo.testXLS}");
            rs = pstmt.executeQuery();

            WorkbookSettings ws = new WorkbookSettings();
            ws.setUseTemporaryFileDuringWrite(true);
            WritableWorkbook w = Workbook.createWorkbook(response.getOutputStream(), ws);
            WritableSheet s = w.createSheet("Всі РЕМ", 0);
            
            WritableFont font = new WritableFont(WritableFont.createFont("Times New Roman"), 12,
                    WritableFont.NO_BOLD,  false, UnderlineStyle.NO_UNDERLINE);
            
            WritableFont fontForData = new WritableFont(WritableFont.createFont("Times New Roman"), 10,
                    WritableFont.NO_BOLD,  false, UnderlineStyle.NO_UNDERLINE);
            
            WritableCellFormat cellFormat = new WritableCellFormat(font);
            cellFormat.setWrap(true);
            cellFormat.setAlignment(Alignment.CENTRE);
            cellFormat.setVerticalAlignment(VerticalAlignment.BOTTOM);
            cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
            cellFormat.setBackground(Colour.GRAY_25);
            cellFormat.setShrinkToFit(true);
            
            WritableCellFormat cellFormat1 = new WritableCellFormat(font);
            cellFormat1.setWrap(true);
            cellFormat1.setAlignment(Alignment.CENTRE);
            cellFormat1.setVerticalAlignment(VerticalAlignment.BOTTOM);
            cellFormat1.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
            cellFormat1.setBackground(Colour.YELLOW);
            cellFormat1.setShrinkToFit(true);
            
            ArrayList<String> header = new ArrayList<String>();
            ArrayList<String> subHeader = new ArrayList<String>();
            ArrayList<String> subHeader2 = new ArrayList<String>();
            ArrayList<String> subHeader3 = new ArrayList<String>();
            ArrayList<String> subHeader4 = new ArrayList<String>();
            ArrayList<String> subHeader5 = new ArrayList<String>();
            ArrayList<String> subHeader6 = new ArrayList<String>();
            ArrayList<String> subHeader7 = new ArrayList<String>();
            ArrayList<String> subHeader8 = new ArrayList<String>();
            ArrayList<String> subHeader9 = new ArrayList<String>();
            header.add("РЕМ"); 
            header.add("Замовник");
            header.add("Дані про об'єкт"); 
            header.add("Вимоги ТУ");
            header.add("Технічні умови №Договір"); 
            header.add("Допуск та проектування");
            header.add("Схема приєднання"); 
            header.add("Плата за приєднання");
            header.add("Дані ВКБ"); 
            header.add("Журнал змін");
            // header.size() = 10

            /*Label(column, row, data, cellFormat);*/
            s.addCell(new Label(0, 0, header.get(0), cellFormat));            
            //mergeCells(col1, row11, col2, row2)
            s.mergeCells(0, 0, 0, 1);
            
            s.addCell(new Label(1, 0, header.get(1), cellFormat));
            s.mergeCells(1, 0, 16, 0);
            
            s.addCell(new Label(17, 0, header.get(2), cellFormat));
            s.mergeCells(17, 0, 40, 0);
            
            s.addCell(new Label(41, 0, header.get(3), cellFormat));
            s.mergeCells(41, 0, 48, 0);
            
            s.addCell(new Label(49, 0, header.get(4), cellFormat));
            s.mergeCells(49, 0, 61, 0);
            
            s.addCell(new Label(62, 0, header.get(5), cellFormat));
            s.mergeCells(62, 0, 75, 0);
            
            s.addCell(new Label(76, 0, header.get(6), cellFormat));
            s.mergeCells(76, 0, 86, 0);
            
            s.addCell(new Label(87, 0, header.get(7), cellFormat));
            s.mergeCells(87, 0, 93, 0);
            
            s.addCell(new Label(94, 0, header.get(8), cellFormat));
            s.mergeCells(94, 0, 116, 0);
            
            s.addCell(new Label(117, 0, header.get(9), cellFormat));
            s.mergeCells(117, 0, 124, 0);
            
            subHeader.add("Соц. Статус");
            subHeader.add("Споживач");
            subHeader.add("Тип договору");
            subHeader.add("Тип договору");
            subHeader.add("Тип приєднання");
            subHeader.add("Ступінь приєднання");
            subHeader.add("Дата звернення (реєстрації в РЕМ)");	
            subHeader.add("№ звернення (реєстрації в РЕМ)");
            subHeader.add("Юрид. назва Замовника");
            subHeader.add("Прізвище І.П.");
            subHeader.add("Установчий документ");
            subHeader.add("Розрахунковий рахунок");
            subHeader.add("МФО, Банк");
            subHeader.add("Ідентифікаційний номер");
            subHeader.add("Адреса");
            subHeader.add("Телефон");
            // subHeader.size() = 16
            
            for(int i = 0; i < subHeader.size(); i++){
                s.addCell(new Label(i+1, 1, subHeader.get(i), cellFormat));
            }             
              
            subHeader2.add("Підстава видачі ТУ");
            subHeader2.add("Назва");
            subHeader2.add("Адреса Об'єкта");	
            subHeader2.add("Розробник ТУ");	
            subHeader2.add("Сума за ТУ");	
            subHeader2.add("Дата оплати");	
            subHeader2.add("Дата введення в експлуатацію");	
            subHeader2.add("Географічні координати точки підключення");	
            subHeader2.add("Географічні координати точки забезпечення потужності");	
            subHeader2.add("Точка приєднання");
            subHeader2.add("Точка забезпечення потужності");	
            subHeader2.add("І-ша кат.");	
            subHeader2.add("ІІ-га кат.");	
            subHeader2.add("ІІІ-тя кат.");	
            subHeader2.add("І-ша кат. кВт.");	
            subHeader2.add("ІІ-га кат. кВт.");	
            subHeader2.add("ІІІ-тя кат. кВт.");	
            subHeader2.add("Заявлена потужність кВт.");	
            subHeader2.add("електронагрівальних пристроїв");	
            subHeader2.add("екологічної броні");	
            subHeader2.add("аварійної броні");	
            subHeader2.add("технологічної броні");	
            subHeader2.add("Номер опори");	
            subHeader2.add("Джерело Живлення");
            // subHeader2.size() = 24
            
            for(int i = 0; i < subHeader2.size(); i++){
                s.addCell(new Label(subHeader.size()+1+i, 1, subHeader2.get(i), cellFormat));
            }
              
            subHeader3.add("У електромережах до прогнозованої межі балансової належності");	
            subHeader3.add("Від межі балансової належності до електроустановок Замовника");
            subHeader3.add("Розрахунковий облік електричної енергії");	
            subHeader3.add("Вимоги до електромереж резервного живлення, в тому числі виділення "
                    + "відповідного електрообладнання на окремі резервні лінії живлення для "
                    + "збереження електропостачання цього електрообладнання у разі виникнення "
                    + "дефіциту потужності в об’єднаній енергосистемі");	
            subHeader3.add("Влаштування захисту від пошкоджень та обмеження дозволеної потужності");	
            subHeader3.add("Вимоги до релейного захисту й автоматики, захисту від коротких замикань "
                    + "та перевантажень, компенсації струмів однофазного замикання в мережах з "
                    + "ізольованою шиною нейтралі тощо");
            subHeader3.add("Вимоги до телемеханіки та зв’язку");	
            subHeader3.add("Специфічні вимоги щодо живлення електроустановок Замовника, які стосуються "
                    + "резервного живлення, допустимості паралельної роботи елементів електричної мережі");
            subHeader3.add("Вимоги до ізоляції захисту від перенапруги");
            // subHeader3.size() = 9
            
            for(int i = 0; i < subHeader3.size(); i++){
                s.addCell(new Label(subHeader.size()+subHeader2.size()+i+1, 1, subHeader3.get(i), cellFormat));
            }
              
            subHeader4.add("Номер Договору (ТУ)");	
            subHeader4.add("Вихідна дата реєстрації ТУ в РЕМ");	
            subHeader4.add("Вихідний номер РЕМ");	
            subHeader4.add("Дата видачі Замовнику ТУ та договору");
            subHeader4.add("Номер вхідної заяви у ВАТ");	
            subHeader4.add("Дата передачі у РЕМ");	
            subHeader4.add("Дата повернення підписаного примірника з РЕМ");	
            subHeader4.add("ОТЗ №");	
            subHeader4.add("Термін дії договору та ТУ");	
            subHeader4.add("Дата укладення договору");	
            subHeader4.add("Закінчення договору ТУ");	
            subHeader4.add("Стан договору");	
            subHeader4.add("Виконання даних ТУ спільно з ТУ №");
            // subHeader4.size() = 13
            
            for(int i = 0; i < subHeader4.size(); i++){
                s.addCell(new Label(subHeader.size()+subHeader2.size()+
                        subHeader3.size()+i+1, 1, subHeader4.get(i), cellFormat));
            }
              
            subHeader5.add("Дата допуску споживача");	
            subHeader5.add("Дата подання заявки");	
            subHeader5.add("Дата подання напруги");	
            subHeader5.add("Дата передачі акту прийому-здачі гол.інженеру");	
            subHeader5.add("Дата погодження гол.інж. акту прийому-здачі");	
            subHeader5.add("Вартість демонтованого устаткування та обладнання, яке "
                    + "підлягає подальшому використання, грн.");	
            subHeader5.add("Дата оплати за проект");	
            subHeader5.add("Номер проектного ТП після допуску");	
            subHeader5.add("Виконавець робіт по виконанню ТУ");	
            subHeader5.add("Орієнтовна загальна вартість виконання ТУ");	
            subHeader5.add("Виконавець");	
            subHeader5.add("Дата погодження");	
            subHeader5.add("Вартість погодження ПКД грн.");	
            subHeader5.add("Дата оплати за погодження ПКД");
            // subHeader5.size() = 14
            
            for(int i = 0; i < subHeader5.size(); i++){
                s.addCell(new Label(subHeader.size()+subHeader2.size()+
                        subHeader3.size()+subHeader4.size()+i+1, 1, subHeader5.get(i), cellFormat));
            }
              
            subHeader6.add("Точка приєднання");
            subHeader6.add("Клас напруги , кВ");
            subHeader6.add("Точка підключення");	
            subHeader6.add("Назва ЛЕП 0,4 (диспет. назва)");	
            subHeader6.add("Підстанція ТП 10/0,4");	
            subHeader6.add("Тип джерела");	
            subHeader6.add("Назва ЛЕП 10кВ (диспет. назва)");	
            subHeader6.add("Підстанція ПС 35/10");	
            subHeader6.add("Назва ЛЕП 35кВ (диспет. назва)");	
            subHeader6.add("Підстанція 110/35/10");	
            subHeader6.add("Назва ЛЕП 110кВ (диспет. назва)");
            // subHeader6.size() = 11
            
            for(int i = 0; i < subHeader6.size(); i++){
                s.addCell(new Label(subHeader.size()+subHeader2.size()+
                        subHeader3.size()+subHeader4.size()+
                        subHeader5.size()+i+1, 1, subHeader6.get(i), cellFormat));
            }
              
            subHeader7.add("Вибір ставки плати за приєднання");	
            subHeader7.add("Ставка за приєднання");	
            subHeader7.add("Вартість приєдання, грн");	
            subHeader7.add("Дата оплати плати за приєднання");	
            subHeader7.add("Термін виконання робіт по приєднанню");	
            subHeader7.add("Вартість плати за нестандартне приєднання, тис. грн.");	
            subHeader7.add("Сума оплати у випадку відмінності від вартості "
                    + "плати за приєднання, тис. грн.");
            // subHeader7.size() = 7
            
            for(int i = 0; i < subHeader7.size(); i++){
                s.addCell(new Label(subHeader.size()+subHeader2.size()+
                        subHeader3.size()+subHeader4.size()+subHeader5.size()+
                        subHeader6.size()+i+1, 1, subHeader7.get(i), cellFormat));
            }
              
            subHeader8.add("Вид робіт");	
            subHeader8.add("Виконавець проекту");	
            subHeader8.add("Дата приймання проектних робіт");	
            subHeader8.add("Вартість розробки проекту, грн.");	
            subHeader8.add("Затверджена кошторисна вартість виконання проекту "
                    + "по відповідному об'єкту, грн.");	
            subHeader8.add("Тип ЛЕП");	
            subHeader8.add("Довжина будівництва/реконструкції ЛЕП 0,4 кВ, км.");	
            subHeader8.add("Довжина будівництва/реконструкції ЛЕП 10 (6) кВ, км");	
            subHeader8.add("Довжина будівництва/реконструкції ЛЕП 35 кВ, км");	
            subHeader8.add("Довжина будівництва/ реконструкції ЛЕП 110 кВ, км");	
            subHeader8.add("Необхідність будівництва (реконструкції, переоснащення, "
                    + "модернізації) ПС (ТП) напругою в кВ");	
            subHeader8.add("Виконавець будівельно-монтажних робіт");	
            subHeader8.add("Дата приймання БМР");	
            subHeader8.add("Вартість будівництва згідно акту, грн");	
            subHeader8.add("Вартість лічильника, грн");	
            subHeader8.add("Дата введення в експлуатацію");	
            subHeader8.add("Сума введення, грн");	
            subHeader8.add("Довжина збудованої ПЛ-0,4кВ,км");	
            subHeader8.add("Довжина збудованої КЛ-0,4кВ,км");	
            subHeader8.add("Потужність збудованих ТП, кВА");	
            subHeader8.add("Довжина збудованої ПЛ-10 кВ,км");	
            subHeader8.add("Кількість збудованих ТП, шт");	
            subHeader8.add("Довжина збудованої КЛ-10 кВ,км");
            // subHeader8.size() = 23
            
            for(int i = 0; i < subHeader8.size(); i++){
                s.addCell(new Label(subHeader.size()+subHeader2.size()+
                        subHeader3.size()+subHeader4.size()+subHeader5.size()+
                        subHeader6.size()+subHeader7.size()+i+1, 1, subHeader8.get(i), cellFormat));
            }
              
            subHeader9.add("Номер додаткового правочину");	
            subHeader9.add("Тип листа (провочина)");	
            subHeader9.add("Вхідний номер");	
            subHeader9.add("Дата заяви");	
            subHeader9.add("Вихідний номер");	
            subHeader9.add("Дата Відповіді");	
            subHeader9.add("ТУ продовжено до");	
            subHeader9.add("Короткий опис");
            // subHeader9.size() = 8
            
            for(int i = 0; i < subHeader9.size(); i++){
                s.addCell(new Label(subHeader.size()+subHeader2.size()+
                        subHeader3.size()+subHeader4.size()+subHeader5.size()+
                        subHeader6.size()+subHeader7.size()+
                        subHeader8.size()+i+1, 1, subHeader9.get(i), cellFormat));
            }
            
            int colsAmmount = subHeader.size()+subHeader2.size()+subHeader3.size()+
                    subHeader4.size()+subHeader5.size()+subHeader6.size()+
                    subHeader7.size()+subHeader8.size() + subHeader9.size();
            
            for(int i = 0; i <= colsAmmount; i++){
                s.setColumnView(i, 30);
            }
            int i=2;
            
            WritableCellFormat data = new WritableCellFormat(fontForData);
            data.setWrap(true);
            data.setAlignment(Alignment.CENTRE);
            data.setVerticalAlignment(VerticalAlignment.CENTRE);
            data.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
            data.setShrinkToFit(true);
            
            WritableCellFormat cellFD = new WritableCellFormat(DateFormats.FORMAT1);
            cellFD.setWrap(true);
            cellFD.setAlignment(Alignment.CENTRE);
            cellFD.setVerticalAlignment(VerticalAlignment.CENTRE);
            cellFD.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
            cellFD.setShrinkToFit(true);
            
            NumberFormat numF = new NumberFormat("#0.##");
            WritableCellFormat cellFF = new WritableCellFormat(numF);
            cellFF.setWrap(true);
            cellFF.setAlignment(Alignment.CENTRE);
            cellFF.setVerticalAlignment(VerticalAlignment.CENTRE);
            cellFF.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
            cellFF.setShrinkToFit(true);            
            
            while(rs.next()){
                /*Label(column, row, data, cellFormat);*/
                for(int j = 1; j <= colsAmmount+1; j++){
                    if(j == 8 || j == 23 || j == 24 || j == 51 || j == 53 || 
                        j == 55 || j == 56 || j == 59 || j == 63 || j == 64 || 
                        j == 65 || j == 66 || j == 67 || j == 69 || j == 74 || 
                        j == 76 || j == 91 || j == 97 || j == 107 || j == 110 || 
                        j == 121 || j == 123 || j == 124){
                        if(rs.getObject(j) == null){
                            s.addCell(new Label(--j, i, "", data));
                            ++j;
                        }
                        else{
                            s.addCell(new DateTime(--j, i, rs.getDate(++j), cellFD));
                        }
                    }
                    else if(j == 22 || j == 35 || j == 36 || j == 37 || j == 38 ||
                        j == 39 || j == 68 || j == 72 || j == 75 || j == 89 ||
                        j == 90 || j == 93 || j == 94 || j == 98 || j == 99 ||
                        j == 101 || j == 102 || j == 103 || j == 104 ||    
                        j == 108 || j == 109 || j == 111 || j == 112 || j == 113 ||
                        j == 114 || j == 115 || /*j == 116 ||*/ j == 117){
                        if(rs.getString(j) == null || rs.getString(j).equals("") 
                            || rs.getString(j).equals("0.00")) {
                            s.addCell(new Label(--j, i, "", data));
                            ++j;
                        }
                        else{
                            s.addCell(new Number(--j, i, rs.getDouble(++j), cellFF));
                        }
                    }
                    else{
                        s.addCell(new Label(--j, i, rs.getString(++j), data));
                    }
                }
                i++;
            }
            
            rs.close();
            pstmt.close();
            c.close();
            
            w.write();
            w.close();
        } catch (WriteException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.getSQLState();
            e.printStackTrace();
        } catch (NamingException ex) {
            ex.printStackTrace();
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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

