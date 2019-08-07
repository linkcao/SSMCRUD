package com.cxt.crud.utils;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class JedisPoolUtil {
    private static volatile JedisPool jedisPool = null;
    private JedisPoolUtil(){};

    public static JedisPool getJedisPool() {
        if(null == jedisPool){
            synchronized (JedisPoolUtil.class){
                if (null == jedisPool)
                {
                    JedisPoolConfig poolConfig = new JedisPoolConfig();
                    poolConfig.setMaxActive(1000 );
                    poolConfig.setMaxIdle(32);
                    poolConfig.setMaxWait(100*1000);  //等待时间
                    poolConfig.setTestOnBorrow(true); //检查连通性

                    jedisPool = new JedisPool(poolConfig,"47.103.67.54",6380);
                }
            }
        }
        return jedisPool;
    }

    public static void release(JedisPool jedisPool , Jedis jedis) {
        if (null != jedis) {
            jedisPool.returnResourceObject(jedis);
        }
    }

}
