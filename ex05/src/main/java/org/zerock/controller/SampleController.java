package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.Criteria;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;


@RequestMapping(value = "/sample/*", method= {RequestMethod.GET, RequestMethod.POST})
@Controller
//@RestController //@Controller + @ResponseBody. json으로 반환할때 사용해. 일반 .jsp페이지 보여주고 싶으면 그냥 @Controller사용해
@Log4j 
public class SampleController {
	
	@GetMapping(value= "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: "+ MediaType.TEXT_PLAIN_VALUE);
		return "�븞�뀞�븯�꽭�슂";
	}
	
	/*
	 * Media type?
	 * 
	 * client - request -> server(spring-controller's GetMapping/RequestMapping, tomcat)
	 * server(spring-controller, tomcat) - response -> client
	 * 
	 * MediaType.APPLICATION_JSON_UTF8_VALUE�씪硫�, �빖�뱾�윭媛� �슂泥�怨� �쓳�떟�쓣 蹂대궪 �븣, �듅�젙���엯�쑝濡쒕쭔 �쓳�떟�븯寃� 留뚮뱾湲� 媛��뒫.
	 * 
	 * request�뿉�뒗 consumes, response�뿉�뒗 produces瑜� �넻�빐 媛��뒫.
	 * 
	 * 留뚯빟 consumes = MediaType.APPLICATION_JSON_UTF8_VALUE �씪硫�, 
	 * 
	 * json �뜲�씠�꽣留� �떞怨좎엳�뒗�븷留� 泥섎━�븯寃좊떎�뒗 �쑜.
	 * 
	 * produces�냽�꽦�� �깮�왂媛��뒫.
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
			<firstName>�뒪��</firstName>
			<lastName>濡쒕뱶</lastName>
		</SampleVO>
		
		2. 1. localhost:5551/sample/getSample.json
		{"mno":112,"firstName":"�뒪��","lastName":"濡쒕뱶"}
	 */
	
	@GetMapping(value="/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113, "濡쒖폆","�씪荑�");
	}
	
	@GetMapping(value="/getList")
	public List<SampleVO> getList(){
		return IntStream.range(1,10).mapToObj(i -> new SampleVO(i, i+" First", i+" Second")).collect(Collectors.toList());
	}
	
	@GetMapping(value="/getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "洹몃（�듃","二쇰땲�뼱"));
		return map;
	}
	
	//ResponseEntity type�� �젙�긽�쟻�씤 �뜲�씠�꽣�씤吏�, 鍮꾩젙�긽�쟻�씤 �뜲�씠�꽣�씤吏� �솗�씤�븿.
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
	
	
	//@PathVariable - url�뿉 理쒕��븳 留롮� �젙蹂대�� �떞怨� �떢�쓣�븣 �궗�슜�븯�뒗 寃�
	//http://localhost:5551/sample/product/hello/204
	@GetMapping("/product/{cat}/{pid}") 
	public String[] getPath(@PathVariable String cat, @PathVariable Integer pid) {
		return new String[] {"category: "+ cat, "productid: "+pid};
	}
	
	//@RequestBody - 二쇰줈 json�뜲�씠�꽣瑜� �꽌踰꾩뿉 蹂대궡�꽌 �썝�븯�뒗 ���엯�쓽 媛앹껜濡� 蹂��솚�븯�뒗 �슜�룄濡� �궗�슜
	//@RequestBody�뒗 �슂泥�(request)�븳 �궡�슜(body)瑜� 泥섎━�븯湲� �븣臾몄뿉, �씪諛섏쟻�씤 �뙆�씪誘명꽣 �쟾�떖諛⑹떇�쓣 �궗�슜�븷 �닔 �뾾�뼱�꽌 PostMapping留� �궗�슜.
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert ....... ticket"+ ticket);
		return ticket;
	}
	
	
	
	//spring-security-practice
	@GetMapping("/all")
	public void doAll(Criteria cri) {
		log.info("do all can access everybody!");
	}
	
	@GetMapping("/member")
	public void doMember(Criteria cri) {
		log.info("logined member!");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("admin only");
	}
	
	
	//37.어노테이션을 이용하는 스프링 시큐리티 설정
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping("/annoMember")
	public void doMember2() {
		log.info("logined annotation member!");
	}
	
	@Secured({"ROLE_ADMIN"}) 
	@GetMapping("/annoAdmin")
	public void doAdmin2() {
		log.info("admin annotation only");
	}
}
