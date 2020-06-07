package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;


//RequestMapping에서 포스트도 받는다고 명시하는게 좋음.
@RestController
@RequestMapping(value = "/sample", method= {RequestMethod.GET, RequestMethod.POST})
@Log4j 
public class SampleController {
	
	@GetMapping(value= "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: "+ MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}
	
	/*
	 * Media type?
	 * 
	 * client - request -> server(spring-controller's GetMapping/RequestMapping, tomcat)
	 * server(spring-controller, tomcat) - response -> client
	 * 
	 * MediaType.APPLICATION_JSON_UTF8_VALUE라면, 핸들러가 요청과 응답을 보낼 때, 특정타입으로만 응답하게 만들기 가능.
	 * 
	 * request에는 consumes, response에는 produces를 통해 가능.
	 * 
	 * 만약 consumes = MediaType.APPLICATION_JSON_UTF8_VALUE 라면, 
	 * 
	 * json 데이터만 담고있는애만 처리하겠다는 뜻.
	 * 
	 * produces속성은 생략가능.
	 */
	
	@GetMapping(value= "/getSample", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, 
												 MediaType.APPLICATION_XML_VALUE }) //Media type?
	public SampleVO getSample() {
		return new SampleVO(112, "A", "B");
	}
	
	/*
		1. localhost:5551/sample/getSample
		
		<SampleVO>
			<mno>112</mno>
			<firstName>스타</firstName>
			<lastName>로드</lastName>
		</SampleVO>
		
		2. 1. localhost:5551/sample/getSample.json
		{"mno":112,"firstName":"스타","lastName":"로드"}
	 */
	
	@GetMapping(value="/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113, "로켓","라쿤");
	}
	
	@GetMapping(value="/getList")
	public List<SampleVO> getList(){
		return IntStream.range(1,10).mapToObj(i -> new SampleVO(i, i+" First", i+" Second")).collect(Collectors.toList());
	}
	
	@GetMapping(value="/getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트","주니어"));
		return map;
	}
	
	//ResponseEntity type은 정상적인 데이터인지, 비정상적인 데이터인지 확인함.
	//http://localhost:5551/sample/check?height=140&weight=60 
	//502 error
	@GetMapping(value="/check", params= {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		SampleVO vo = new SampleVO(0,""+height, ""+weight);
		ResponseEntity<SampleVO> result = null;
		
		if(height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	
	//@PathVariable - url에 최대한 많은 정보를 담고 싶을때 사용하는 것
	//http://localhost:5551/sample/product/hello/204
	@GetMapping("/product/{cat}/{pid}") 
	public String[] getPath(@PathVariable String cat, @PathVariable Integer pid) {
		return new String[] {"category: "+ cat, "productid: "+pid};
	}
	
	//@RequestBody - 주로 json데이터를 서버에 보내서 원하는 타입의 객체로 변환하는 용도로 사용
	//@RequestBody는 요청(request)한 내용(body)를 처리하기 때문에, 일반적인 파라미터 전달방식을 사용할 수 없어서 PostMapping만 사용.
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert ....... ticket"+ ticket);
		return ticket;
	}
}
