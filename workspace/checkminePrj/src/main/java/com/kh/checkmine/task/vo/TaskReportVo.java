package com.kh.checkmine.task.vo;

import lombok.Data;

@Data
public class TaskReportVo {
	private String no;
	private String taskNo;
	private String deptNo;
	private String sender;
	private String title;
	private String content;
	private String enrollDate;
	private String modifyDate;
	private String del;
	
	private String attName;
	private String rattName;
	
	private String posName;

}
