package top.weidong.mail;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

import java.io.*;
import java.util.Properties;
import java.util.Random;

/**
 * Created with IntelliJ IDEA.
 * Description:
 *
 * @author dongwei
 * @date 2018/06/06
 * Time: 15:35
 */
public class SendMail {

    private static Properties properties = null;


    /**
     * @param userName 发件人邮箱
     * @param passwd   用户名密码
     * @param title    标题
     * @param to       发给谁
     * @param msg      消息
     * @throws EmailException
     */
    private static void send(String userName, String passwd, String title, String[] to, String msg) throws EmailException {
        Email email = new SimpleEmail();
        email.setHostName("smtp.exmail.qq.com");
        email.setSmtpPort(465);
        email.setAuthenticator(new DefaultAuthenticator(userName, passwd));
        email.setSSLOnConnect(true);
        email.setFrom(userName);
        email.setSubject(title);
        email.setMsg(msg);
        for (String toWhom : to) {
            email.addTo(toWhom);
        }
        email.send();
    }

    public static void main(String[] args) throws EmailException, IOException {

        if (args.length > 0) {
            print("传入的命令行参数为：" + args[0]);
            String confFileName = args[0];
            loadFile(confFileName);
            print("配置文件内容的长度为：" + properties.size());
        } else {
            print("未传入日报内容配置文件！");
            System.exit(1);
        }
        String task = genNextTaskMsg();
        String admin = load("admin");
        String leader = load("leader");
        send("wei.dong@ectrip.com", "19931226dongW", "日报", new String[]{admin, leader}, task);
    }

    private static Properties loadFile(String fileName) throws IOException {
        if (fileName == null) {
            fileName = "conf/tasks.properties";
        }
        Properties p = new Properties();
        InputStream resourceAsStream = SendMail.class.getClassLoader().getResourceAsStream(fileName);
        p.load(new InputStreamReader(resourceAsStream, "utf-8"));
        properties = p;
        return properties;
    }

    /**
     * 通过键获取值
     *
     * @param key
     * @return
     * @throws IOException
     */
    private static String load(String key) throws IOException {
        return properties.getProperty(key);
    }

    private static String randomKey(int size) {
        Random random = new Random();
        return String.valueOf(random.nextInt(size));
    }

    private static String genNextTaskMsg() throws IOException {
        int size = properties.size();
        size = size - 2;
        String task = load(randomKey(size));
        print("随机取出来的任务为：" + task);
        return task;
    }

    private static void print(String msg) {
        System.out.println("+++++++INFO++++++++++");
        System.out.println(msg);
    }
}
