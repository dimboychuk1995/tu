package Utils;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * Created by us9522 on 03.01.2017.
 */
public class md5ApacheCl {


  public static String md5Apache(String st) {
    String md5Hex = DigestUtils.md5Hex(st);

    return md5Hex;
  }
}
