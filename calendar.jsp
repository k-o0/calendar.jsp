<%@ page contentType="text/html; charset=Windows-31J"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.ZoneId"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="ja_JP" />
<%!
    private static Map eventMap = new HashMap();
  static {

Map eventMap = new HashMap();
eventMap.put("20190101","お正月");
eventMap.put("20190114","成人の日");
eventMap.put("20190211","建国記念の日");
eventMap.put("20190321","春分の日");
eventMap.put("20190429","昭和の日");
eventMap.put("20190430","国民の休日");
eventMap.put("20190501","新天皇即位日");

eventMap.put("20190502","国民の休日");
eventMap.put("20190503","憲法記念日");
eventMap.put("20190504","みどりの日");
eventMap.put("20190505","こどもの日");
eventMap.put("20190506","振替休日");
eventMap.put("20190715","海の日");
eventMap.put("20190811","山の日");
eventMap.put("20190812","振替休日");
eventMap.put("20190916","敬老の日");
eventMap.put("20190923","秋分の日");
eventMap.put("20191014","体育の日");
eventMap.put("20191022","即位礼正殿の儀");
eventMap.put("20191103","文化の日");
eventMap.put("20191104","振替休日");
eventMap.put("20191123","勤労感謝の日");
eventMap.put("20191225","クリスマス");
eventMap.put("20191231","大晦日");

}
%>
<%

//リクエストのパラメーターから日付を取り出す
String year = (String) request.getParameter("year");
String month = (String) request.getParameter("month");
String day = (String) request.getParameter("day");
LocalDate localDate = null;
if (year == null || month == null || day == null) {
	//日付が送信されていないので、現在時刻を元に日付の設定を行う
	localDate = LocalDate.now();
	year = String.valueOf(localDate.getYear());
	month = String.valueOf(localDate.getMonthValue());
	day = String.valueOf(localDate.getDayOfMonth());
} else {
	//送信された日付を元に、LocalDateのインスタンスを生成する
	localDate = LocalDate.of(Integer.valueOf(year), Integer.valueOf(month), Integer.valueOf(day));
}
String[] dates = { year, month, day };

//画面で利用するための日付、イベント情報を保存
session.setAttribute("dates", dates);
session.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

String event = (String) eventMap.get(year + month + day);
session.setAttribute("event", event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calender</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
	<form method="POST" action="/jsp/calendar.jsp">
		<ul>
			<li><input type="text" name="year" value="${param['year']}" /><label
				for="year">年 </label><input type="text" name="month"
				value="${param['month']}" /><label for="month">月 </label><input
				type="text" name="day" value="${param['day']}" /><label for="day">日</label></li>
			<li><input type="submit" value="送信" />
			<li><c:out value="${fn:join(dates, '/')}" />  
			(<fmt:formatDate value="${date}" pattern="E" />)
			</li>
			<li><c:out value="${event}" /></li>
		</ul>
	</form>
</body>
</html>
