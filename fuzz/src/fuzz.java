import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.file.Path;
import com.nulabinc.zxcvbn.Zxcvbn;
import com.nulabinc.zxcvbn.Strength;

public class fuzz {
    public static void main(String[] args) throws Exception
    {
        Path path = Paths.get(args[0]);
        byte[] data = Files.readAllBytes(path);
        if(data.length == 0) {
            return;
        }

        Zxcvbn zxcvbn = new Zxcvbn();
        Strength strength = zxcvbn.measure(new String(data));
    }
}
