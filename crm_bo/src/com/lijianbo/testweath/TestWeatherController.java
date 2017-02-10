package com.lijianbo.testweath;

import cn.com.WebXml.WeatherWebServiceLocator;
import cn.com.WebXml.WeatherWebServiceSoap;
import cn.com.WebXml.WeatherWebServiceSoapProxy;
 
/**
 * 测试天气预报 webservice 接口
 * @author bbo
 *
 */
public class TestWeatherController {
	static WeatherWebServiceSoapProxy weatherWebServiceSoapProxy= new WeatherWebServiceSoapProxy();
	
	/**
	 * 获取输入城市的天气预报
	 *  
	 */
	 public static void main(String[] args) throws  Exception {
		 //下面这两种实际是一样的，第一个是代理类，封装了的，第二个直接调用，没有封装
		 //①
//		 String[] weathers = weatherWebServiceSoapProxy.getWeatherbyCityName("成都");
//		 for (String string : weathers) {
//			 System.out.println(string);
//		}
		 //②
		 WeatherWebServiceLocator weatherWebServiceLocator = new WeatherWebServiceLocator();
		 WeatherWebServiceSoap weatherWebServiceSoap = weatherWebServiceLocator.getWeatherWebServiceSoap();
		 String[] weaths = weatherWebServiceSoap.getWeatherbyCityName("深圳");
		 System.out.println("城市："+weaths[0]+weaths[1]);
		 System.out.println("时间："+weaths[4].substring(0,8));
		 System.out.println("温度："+weaths[5]);
		 System.out.println(weaths[10]);
		 System.out.println("城市简介："+weaths[22]);
	 }
}
/*打印结果为：
 * 
 * 城市：广东深圳
时间：2017-2-9
温度：8℃/15℃
今日天气实况：气温：14℃；风向/风力：北风 2级；湿度：48%；紫外线强度：弱。空气质量：良。
城市简介深圳市位于广东省中南沿海地区，珠江入海口之东偏北。深圳市地处中华人民共和国广东省中南沿海，陆域位置东经113°46′至114°37′，北纬22°27′至22°52′。东西长81.4公里，南北宽（最短处）为10.8公里，东临大鹏湾，西连珠江口，南邻香港，与九龙半岛接壤，与香港新界一河之隔，被称为“香港的后花园”。深圳这座新兴的城市整洁美丽，四季草木葱笼，当地政府因地制宜地开发了不少旅游景点，将自然风光与人工建筑巧妙结合。深圳历史悠久，文化发达，旅游资源也十分丰富，保存在地上、地下的文物古迹十分丰富。80年代深圳博物馆考古人员进行了文物普查，发现了一大批颇有价值的古建筑、古遗址、古墓葬、古寺庙、古城址和风景名胜等。深圳市人民政府于1983年先后公布了两批重点文物保护单位，并对名胜古迹作了修复，再现了原有的风貌，以供游人观赏。深圳地处北回归线以南,属亚热带海洋性气候,气候温和,雨量充沛,日照时间长。夏无酷暑,时间长达6个月。春秋冬三季气候温暖,无寒冷之忧。年平均气温为22.3℃。景观：锦绣中华、世界之窗、明思克航母世界、欢乐谷
 
 
所有的返回数据 String[] weaths 为：
 
广东
深圳
59493
59493.jpg
2017-2-9 17:40:08
8℃/15℃
2月9日 多云
北风4-5级转5-6级
1.gif
1.gif
今日天气实况：气温：13℃；风向/风力：西北风 3级；湿度：48%；紫外线强度：弱。空气质量：良。
紫外线指数：弱，辐射较弱，涂擦SPF12-15、PA+护肤品。
感冒指数：极易发，强降温，天气寒冷，风力较强。
穿衣指数：较冷，建议着厚外套加毛衣等服装。
洗车指数：较不宜，风力较大，洗车后会蒙上灰尘。
运动指数：较不宜，天气寒冷，推荐您进行室内运动。
空气污染指数：良，气象条件有利于空气污染物扩散。
 
8℃/16℃
2月10日 多云
东北风4-5级
1.gif
1.gif
9℃/18℃
2月11日 多云
无持续风向微风转东北风3-4级
1.gif
1.gif
深圳市位于广东省中南沿海地区，珠江入海口之东偏北。深圳市地处中华人民共和国广东省
中南沿海，陆域位置东经113°46′至114°37′，北纬22°27′至22°52′。东西长81.4公里，
南北宽（最短处）为10.8公里，东临大鹏湾，西连珠江口，南邻香港，与九龙半岛接壤，与香
港新界一河之隔，被称为“香港的后花园”。深圳这座新兴的城市整洁美丽，四季草木葱笼，
当地政府因地制宜地开发了不少旅游景点，将自然风光与人工建筑巧妙结合。深圳历史悠久，
文化发达，旅游资源也十分丰富，保存在地上、地下的文物古迹十分丰富。80年代深圳博物馆考
古人员进行了文物普查，发现了一大批颇有价值的古建筑、古遗址、古墓葬、古寺庙、古城址和
风景名胜等。深圳市人民政府于1983年先后公布了两批重点文物保护单位，并对名胜古迹作了修
复，再现了原有的风貌，以供游人观赏。深圳地处北回归线以南,属亚热带海洋性气候,气候温和,
雨量充沛,日照时间长。夏无酷暑,时间长达6个月。春秋冬三季气候温暖,无寒冷之忧。年平均气
温为22.3℃。景观：锦绣中华、世界之窗、明思克航母世界、欢乐谷
 
  */