package com.lijianbo.client;

import java.rmi.RemoteException;

import javax.xml.rpc.ServiceException;

import com.hello.HelloService;
import com.hello.MyService;


public class TestHello {
	
	 /**
     * 通过wsimport 解析wsdl生成客户端代码调用WebService服务
     * 
     * 运行测试类就能成功调用服务器的接口，得到返回数据。
     * 
     */
	
    public static void main(String[] args) throws ServiceException, RemoteException {
        /**
         * <service name="MyService">
         * 获得服务名称
         */
        MyService mywebService = new MyService();
        
        /**
         * <port name="HelloServicePort" binding="tns:HelloServicePortBinding">
         */
       HelloService hs = mywebService.getHelloServicePort();
        System.out.println("hs:"+hs);
        /**
         * 调用方法
         */
        System.out.println(hs.sayGoodbye("sjk============="));
        System.out.println(hs.aliassayHello("sjk================"));
    }
  
	
	
}
