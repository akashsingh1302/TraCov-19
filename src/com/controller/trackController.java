package com.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.controller.dataList;

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

@Controller 
public class trackController {
@RequestMapping("/")
public String homeFunc()
{
	return "home";
	}
@RequestMapping("/home")
public ModelAndView defaultFunc()
{
	ModelAndView mv = new ModelAndView();
	Rengine re = Rengine.getMainEngine();
    if(re == null){
        re=new Rengine (new String [] {"--vanilla"}, false, null);
        if (!re.waitForR())
        {
            System.out.println ("Cannot load R");
                    }
    }
	String rFilePath = "C:/Users/College/eclipse-workspace1/traCov/WebContent/resources/Graph.R";
	re.eval("source(\"" + rFilePath + "\")");
	re.eval("gompertz()");
	re.end();
	double d_Origx[] = re.eval("getOrigX()").asDoubleArray();
	double d_Origy[] = re.eval("getOrigY()").asDoubleArray();
	int Origx[] = new int[d_Origx.length];
    int Origy[] = new int[d_Origy.length];
    for(int i=0;i<d_Origx.length;i++)
    {
    	Origx[i] = (int)d_Origx[i];
    	Origy[i] = (int)d_Origy[i];
    }
    System.out.println(Origx[1]);
    mv.addObject("Origx",Origx);
	mv.addObject("Origy", Origy);
	mv.setViewName("index.jsp");
	return mv;
}
@RequestMapping("/target")
public ModelAndView targetFunc()
{

	ModelAndView mv = new ModelAndView();
	
	 Rengine re = Rengine.getMainEngine();
     if(re == null){
         re=new Rengine (new String [] {"--vanilla"}, false, null);
         if (!re.waitForR())
         {
             System.out.println ("Cannot load R");
                     }
     }
	String date = "18/05/2020";
     String rFilePath = "C:/Users/College/eclipse-workspace1/traCov/WebContent/resources/Map.R";
	re.eval("source(\"" + rFilePath + "\")");
	re.assign("date", date);
	re.eval("setByDate()");
	re.eval("setShp()");
	double d_cases[] = re.eval("getCases()").asDoubleArray();
    String states[] = re.eval("getStates()").asStringArray();
    double d_cluster[] = re.eval("getClusters()").asDoubleArray();
	re.end();
	int cases[] = new int[d_cases.length];
	int cluster[] = new int [d_cluster.length];
	for(int i=0;i<d_cases.length;i++)
	{
		cases[i] = (int)d_cases[i];
		cluster[i] = (int)d_cluster[i];
	}
	stateList[] sl = new stateList[cases.length];
	for(int i=0;i<states.length;i++)
	{
		sl[i] = new stateList();
		sl[i].setCases(cases[i]);
		sl[i].setCluster(cluster[i]);
		sl[i].setState(states[i]);
	}
	mv.addObject("date",date);
	mv.addObject("stateList",sl);
	mv.setViewName("target.jsp");
	return mv;
}
@RequestMapping("gompertz")
public ModelAndView getGompertzGraph()
{
	ModelAndView mv = new ModelAndView();
	 Rengine re = Rengine.getMainEngine();
     if(re == null){
         re=new Rengine (new String [] {"--vanilla"}, false, null);
         if (!re.waitForR())
         {
             System.out.println ("Cannot load R");
         }
     }
	
	String rFilePath = "C:/Users/College/eclipse-workspace1/traCov/WebContent/resources/Graph.R";
	re.eval("source(\"" + rFilePath + "\")");
	re.eval("gompertz()");
	re.end();
	double d_Origx[] = re.eval("getOrigX()").asDoubleArray();
	double d_Origy[] = re.eval("getOrigY()").asDoubleArray();
	double d_Resx[] = re.eval("getResX()").asDoubleArray();
	double d_Resy[] = re.eval("getResY()").asDoubleArray();
    int Origx[] = new int[d_Origx.length];
    int Origy[] = new int[d_Origy.length];
    int Resx[] = new int[d_Resx.length];
    int Resy[] = new int[d_Resy.length];
    for(int i=0;i<d_Origx.length;i++)
    {
    	Origx[i] = (int)d_Origx[i];
    	Origy[i] = (int)d_Origy[i];
    }
    for(int i=0;i<d_Resx.length;i++)
    {
    	Resx[i] = (int)d_Resx[i];
    	Resy[i] = (int)d_Resy[i];
    }
    dataList Orig[] = new dataList[Origx.length];
    dataList Res[] = new dataList[Resx.length];

	for(int i=0;i<Resx.length;i++)
	{
		Res[i] = new dataList();
		Res[i].x = Resx[i];
		Res[i].y = Resy[i];
	}
	for(int i=0;i<Origx.length;i++)
	{
		Orig[i] = new dataList();
		Orig[i].x = Origx[i];
		Orig[i].y = Origy[i];
	}
	mv.addObject("Resy",Resy);
	mv.addObject("Origy", Origy);
	mv.setViewName("gompertz.jsp");
	return mv;
	}
@RequestMapping("logistic")
public ModelAndView getLogisticGraph()
{
	ModelAndView mv = new ModelAndView();
	 Rengine re = Rengine.getMainEngine();
     if(re == null){
         re=new Rengine (new String [] {"--vanilla"}, false, null);
         if (!re.waitForR())
         {
             System.out.println ("Cannot load R");
         }
     }
	
	String rFilePath = "C:/Users/College/eclipse-workspace1/traCov/WebContent/resources/Graph.R";
	re.eval("source(\"" + rFilePath + "\")");
	re.eval("logistic()");
	re.end();
	double d_Origx[] = re.eval("getOrigX()").asDoubleArray();
	double d_Origy[] = re.eval("getOrigY()").asDoubleArray();
	double d_Resx[] = re.eval("getResX()").asDoubleArray();
	double d_Resy[] = re.eval("getResY()").asDoubleArray();
    int Origx[] = new int[d_Origx.length];
    int Origy[] = new int[d_Origy.length];
    int Resx[] = new int[d_Resx.length];
    int Resy[] = new int[d_Resy.length];
    for(int i=0;i<d_Origx.length;i++)
    {
    	Origx[i] = (int)d_Origx[i];
    	Origy[i] = (int)d_Origy[i];
    }
    for(int i=0;i<d_Resx.length;i++)
    {
    	Resx[i] = (int)d_Resx[i];
    	Resy[i] = (int)d_Resy[i];
    }
    dataList Orig[] = new dataList[Origx.length];
    dataList Res[] = new dataList[Resx.length];

	for(int i=0;i<Resx.length;i++)
	{
		Res[i] = new dataList();
		Res[i].x = Resx[i];
		Res[i].y = Resy[i];
	}
	for(int i=0;i<Origx.length;i++)
	{
		Orig[i] = new dataList();
		Orig[i].x = Origx[i];
		Orig[i].y = Origy[i];
	}
	mv.addObject("Resy",Resy);
	mv.addObject("Origy", Origy);
	mv.setViewName("logistic.jsp");
	return mv;
	}
@RequestMapping("bertalanffy")
public ModelAndView getbertalanffyGraph()
{
	ModelAndView mv = new ModelAndView();
	 Rengine re = Rengine.getMainEngine();
     if(re == null){
         re=new Rengine (new String [] {"--vanilla"}, false, null);
         if (!re.waitForR())
         {
             System.out.println ("Cannot load R");
         }
     }
	
	String rFilePath = "C:/Users/College/eclipse-workspace1/traCov/WebContent/resources/Graph.R";
	re.eval("source(\"" + rFilePath + "\")");
	re.eval("bertalanffy()");
	re.end();
	double d_Origx[] = re.eval("getOrigX()").asDoubleArray();
	double d_Origy[] = re.eval("getOrigY()").asDoubleArray();
	double d_Resx[] = re.eval("getResX()").asDoubleArray();
	double d_Resy[] = re.eval("getResY()").asDoubleArray();
    int Origx[] = new int[d_Origx.length];
    int Origy[] = new int[d_Origy.length];
    int Resx[] = new int[d_Resx.length];
    int Resy[] = new int[d_Resy.length];
    for(int i=0;i<d_Origx.length;i++)
    {
    	Origx[i] = (int)d_Origx[i];
    	Origy[i] = (int)d_Origy[i];
    }
    for(int i=0;i<d_Resx.length;i++)
    {
    	Resx[i] = (int)d_Resx[i];
    	Resy[i] = (int)d_Resy[i];
    }
    dataList Orig[] = new dataList[Origx.length];
    dataList Res[] = new dataList[Resx.length];

	for(int i=0;i<Resx.length;i++)
	{
		Res[i] = new dataList();
		Res[i].x = Resx[i];
		Res[i].y = Resy[i];
	}
	for(int i=0;i<Origx.length;i++)
	{
		Orig[i] = new dataList();
		Orig[i].x = Origx[i];
		Orig[i].y = Origy[i];
	}
	mv.addObject("Resy",Resy);
	mv.addObject("Origy", Origy);
	mv.setViewName("bertalanffy.jsp");
	return mv;
	}


@RequestMapping("state")
public ModelAndView getStateGraph()
{
	ModelAndView mv = new ModelAndView();

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
    for(int i=0;i<d_Origx.length;i++)
    {
    	Origx[i] = (int)d_Origx[i];
    	Origy[i] = (int)d_Origy[i];
    }
   	mv.addObject("Origx",Origx);
	mv.addObject("Origy", Origy);
	mv.setViewName("states.jsp");
	return mv;
	}

}
