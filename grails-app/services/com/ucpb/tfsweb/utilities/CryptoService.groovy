package com.ucpb.tfsweb.utilities

import groovy.util.logging.Slf4j
import org.apache.commons.codec.binary.Base64
import org.apache.commons.io.IOUtils

import javax.crypto.BadPaddingException
import javax.crypto.Cipher
import javax.crypto.IllegalBlockSizeException
import javax.crypto.KeyGenerator
import javax.crypto.NoSuchPaddingException
import javax.crypto.SecretKey
import javax.crypto.spec.SecretKeySpec
import java.security.GeneralSecurityException
import java.security.InvalidKeyException
import java.security.Key
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException


/**
 * Crypto Service.
 *
 * @author Sergio Paulino/Psalmer Valdez/Kei Shirabe/Brent Macatangay
 */
@Slf4j
class CryptoService {

    private static final String ALGORITHM = "AES"
    private static final String TRANSFORMATION = "AES"
    private static final String SECRET_KEY = "secret"

    /**
     * Encrypt file.
     * @param keyFile
     * @param inputFile
     * @param outputFile
     * @throws Exception
     */
    static void encryptFile(File keyFile, File inputFile, File outputFile) throws Exception {
        fileEncrypt(Cipher.ENCRYPT_MODE, keyFile, inputFile, outputFile)
    }

    /**
     * Decrypt file.
     * @param keyFile
     * @param inputFile
     * @param outputFile
     * @throws Exception
     */
    static void decryptFile(String key, File inputFile, File outputFile) throws Exception {
        fileEncrypt(Cipher.DECRYPT_MODE, key, inputFile, outputFile)
    }

    private static void fileEncrypt(int cipherMode, String key, File inputFile,
                                    File outputFile) throws Exception {
        try {

            Key secretKey = getSecretKeySpec(key)
            Cipher cipher = Cipher.getInstance(TRANSFORMATION)
            cipher.init(cipherMode, secretKey)

            FileInputStream inputStream = new FileInputStream(inputFile)
            byte[] inputBytes = new byte[(int) inputFile.length()]
            inputStream.read(inputBytes)

            byte[] outputBytes = cipher.doFinal(inputBytes)
            FileOutputStream outputStream = new FileOutputStream(outputFile)
            outputStream.write(outputBytes)

            inputStream.close()
            outputStream.close()

        }
        catch(BadPaddingException ex){
            throw new BadPaddingException(ex.getMessage())
        }
        catch(NoSuchPaddingException ex){
            throw new NoSuchPaddingException(ex.getMessage())
        }
        catch(NoSuchAlgorithmException ex){
            throw new NoSuchAlgorithmException(ex.getMessage())
        }
        catch(InvalidKeyException ex){
            throw new InvalidKeyException(ex.getMessage())
        }
        catch(IllegalBlockSizeException ex){
            throw new IllegalBlockSizeException(ex.getMessage())
        }
        catch (IOException ex) {
            throw new Exception("Error encrypting/decrypting file", ex)
        }
    }

    private static SecretKeySpec getSecretKeySpec(String key)
            throws NoSuchAlgorithmException, IOException {
        byte[] bKey = readKey(key)
        SecretKeySpec sks = new SecretKeySpec(bKey, ALGORITHM)
        return sks
    }

    private static byte[] readKey(String key) {
        return hexStringToByteArray(key)
    }

    private static String byteArrayToHexString(byte[] b) {
        StringBuffer sb = new StringBuffer(b.length * 2)
        for (int i = 0; i < b.length; i++) {
            int v = b[i] & 0xff
            if (v < 16) {
                sb.append('0')
            }
            sb.append(Integer.toHexString(v))
        }
        return sb.toString().toUpperCase()
    }

    private static byte[] hexStringToByteArray(String s) {
        byte[] b = new byte[s.length() / 2]
        for (int i = 0; i < b.length; i++) {
            int index = i * 2
            int v = Integer.parseInt(s.substring(index, index + 2), 16)
            b[i] = (byte) v
        }
        return b
    }
}
