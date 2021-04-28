package com.test;

import java.io.Console;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

import javax.sound.sampled.Line;
import org.rosuda.JRI.REXP;
import org.rosuda.JRI.Rengine;

import com.controller.stateList;
public class testR {
public static void main(String args []) throws IOException
{
	/*Path path = Paths.get("C:\\Users\\College\\eclipse-workspace\\RJava\\resources\\Map.R");
	List<String> lines = Files.readAllLines(path);
	lines.stream().forEach((line) -> {
		re.eval(line);
	});*/
	//String rFilePath = "C:/Users/College/eclipse-workspace/RJava/resources/Map.R";
	Rengine re = Rengine.getMainEngine();
    if(re == null){
        re=new Rengine (new String [] {"--vanilla"}, false, null);
        if (!re.waitForR())
        {
            System.out.println ("Cannot load R");
        }
    }
	
	String rFilePath = "C:/Users/College/eclipse-workspace1/traCov/WebContent/resources/states.R";
	re.eval("source(\"" + rFilePath + "\")");
	re.assign("stateName", "Gujarat");
	re.eval("gompertz()");
	double d_Origx[] = re.eval("getOrigX()").asDoubleArray();
	double d_Origy[] = re.eval("getOrigY()").asDoubleArray();
	re.end();
	int Origx[] = new int[d_Origx.length];
   int Origy[] = new int[d_Origy.length];
   System.out.println(d_Origy[115]);	
}
}

