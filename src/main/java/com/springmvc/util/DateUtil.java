package com.springmvc.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
* @Title: DateUtil
* @Description: 日期操作类
* @author chy
* @date 2017/11/17 9:31
*/
public class DateUtil {

	/**
	 * 当前日期转换为字符串.格式:yyyy-MM-dd HH:mm:ss
	 * 
	 * @param date
	 *            日期.
	 * @return 日期的字符串.
	 */
	public static String formatDate(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}

	/**
	 * 返回特定格式的日期字符串.eg:yyyy-MM-dd HH:mm:ss
	 * 
	 * @param date
	 * @param patten
	 * @return
	 */
	public static String formatDate(Date date, String patten) {
		SimpleDateFormat format = new SimpleDateFormat(patten);
		return format.format(date);
	}


	/**
	 * 当前 Timestamp
	 * 
	 * @return
	 */
	public static Timestamp currrentDate() {
		return new Timestamp(System.currentTimeMillis());
	}


	/**
	 * 判断白天黑夜
	 *
	 * @return
	 */

	public static String getDayOrNight(String beginTime, String dateBeginTime, String dateEndTime) {
		SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
		try {
			Date startDate = format.parse(beginTime.split(" ")[1]);
			format.applyPattern("HH:mm");
			Date sDate = format.parse(dateBeginTime);
			Date eDate = format.parse(dateEndTime);
			if (sDate.compareTo(startDate) <= 0 && eDate.compareTo(startDate) > 0) {
				return "HOUR";
			} else {
				return "ALL";
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 时间段比大小
	 * @param firstTime
	 * @param secondTime
	 * @return
	 */
	public static int compareTime(String firstTime, String secondTime) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date fDate = format.parse(firstTime);
			Date sDate = format.parse(secondTime);
			if (sDate.compareTo(fDate) < 0) {
				return 1;
			} else {
				return 2;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return 0;
	}


	/**
	 * 将字符串转换为Date类型
	 * @param dateTime
	 * @return
	 */
	public static Date stringToDate(String dateTime) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = null;
		try {
			date = format.parse(dateTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 相差几个秒
	 * 
	 * @param bDate
	 * @param eDate
	 * @return
	 */
	public static int computerDivideSecond(Date bDate, Date eDate) {
		return (int) (((eDate.getTime() - bDate.getTime()) / 1000));
	}

	/**
	 * 相差几个分钟
	 * 
	 * @param bDate
	 * @param eDate
	 * @return
	 */
	public static int computerDivideMinute(Date bDate, Date eDate) {
		return (int) (((eDate.getTime() - bDate.getTime()) / 1000) / (60));
	}

	/**
	 * 相差几个小时
	 * 
	 * @param bDate
	 * @param eDate
	 * @return
	 */
	public static int computerDivideHour(Date bDate, Date eDate) {
		return (int) (((eDate.getTime() - bDate.getTime()) / 1000) / (60 * 60));
	}

	/**
	 * 相差几天
	 * 
	 * @param bDate
	 * @param eDate
	 * @return
	 */
	public static int computerDivideDay(Date bDate, Date eDate) {
		return (int) (((eDate.getTime() - bDate.getTime()) / 1000) / (24 * 60 * 60));
	}

	/**
	 * 相差几天几小时几分几秒
	 * day + "天" + hour + "时" + min + "分" + sec + "秒"
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static String dateDiff(Date startTime, Date endTime) {
		StringBuilder str = new StringBuilder();
		// 一天的毫秒数
		long nd = 1000 * 24 * 60 * 60;
		// 一小时的毫秒数
		long nh = 1000 * 60 * 60;
		// 一分钟的毫秒数
		long nm = 1000 * 60;
		// 一秒钟的毫秒数
		long ns = 1000;
		long diff;
		try {
			// 获得两个时间的毫秒时间差异
			diff = endTime.getTime() - startTime.getTime();
			// 计算差多少天
			long day = diff / nd;
			// 计算差多少小时
			long hour = diff % nd / nh;
			// 计算差多少分钟
			long min = diff % nd % nh / nm;
			// 计算差多少秒
			long sec = diff % nd % nh % nm / ns;
			if (day != 0) {
				str.append(day).append("天 ");
			}
			if (hour != 0) {
				str.append(hour).append("小时 ");
			}
			if (min != 0) {
				str.append(min).append("分 ");
			}
			if (sec != 0) {
				str.append(sec).append("秒 ");
			}
			return str.toString();
		} catch (Exception e) {
			return null;
		}
	}
}
