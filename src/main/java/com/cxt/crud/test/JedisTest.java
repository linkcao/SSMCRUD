package com.cxt.crud.test;

import com.cxt.crud.utils.JedisPoolUtil;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.Transaction;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class JedisTest {
    public static void main(String[] args) {
       // Jedis jedisM = new Jedis("192.168.67.129",6379);
        //Jedis jedisS = new Jedis("192.168.67.129",6380);
//        System.out.println(jedis.ping());
        //jedis.set("k1","v9");
//        Set<String> set = jedis.keys("*");
//        Map<String,String> map = new HashMap<String,String>();
//        map.put("id","125540");
//        map.put("name","hello");
//        jedis.hmset("emp",map);
//        System.out.println(jedis.hmget("emp","id","name"));
//        Transaction transaction = jedis.multi();
//        transaction.set("k4","v4");
//        transaction.set("k5","v5");
//       // transaction.exec();//正常执行
        // transaction.discard(); //取消执行
//        jedisS.slaveof("192.168.67.129",6379); //从认主
//
//        jedisM.set("class","1122");//主写
//
//        String result = jedisS.get("class");//从读 硬盘较慢复制 得到的值是内从速度得到的 可能为空第二次可以执行
//        System.out.println(result);
        JedisPool jedisPool = JedisPoolUtil.getJedisPool();
        Jedis jedis = null;
            try {

            //        JedisPool jedisPool2 = JedisPoolUtil.getJedisPool();
                jedis = jedisPool.getResource();
                jedis.set("hello","world");
                System.out.println(jedis.get("hello"));
            }catch (Exception e){
            e.printStackTrace();
            }finally {
                JedisPoolUtil.release(jedisPool,jedis);
            }
    }
}
