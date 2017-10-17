package com.springmvc.model;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.AccessLevel;

@Data
@ToString
@NoArgsConstructor
public class Lombok {
   
	@Getter
	@Setter
	private String  lname;
	
	@Setter(AccessLevel.PROTECTED)
    private String  type;	
	
}
