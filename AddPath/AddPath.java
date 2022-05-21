/**=================================================================<br>
 * Project     : TS
 * Program     : AddPath.java
 * Stand       : 00.00.2012 (compare to file-date)
 * Version     : J3.x
 * Modul-ID    : -none-
 *
 * Description : Add a path-value to an environment-variable within
 *                 a windows registry-container. The value is added
 *                 using ';' as a separator. If the environment-
 *                 variable is not found, it is created and initialized
 *                 to '.'
 * Remark      :  -none-
 *
 =====================================================================*/
import java.io.*;
import java.util.*;
/**=====================================================================
 * Class AddPath
 * ##AddPath (Eyecatcher)
 =====================================================================*/
public class AddPath implements Serializable { /* Add variable (Basis) */
 /*-------------------------------------------------------------------*/
  protected static final String Version = "1.1.01"; /* akt. Version */
 /**====================================================================
  * Constructor: (1) create default-entry
  ====================================================================*/
  public AddPath() /* Constructor is not explicitely used */
   {
   /*-----------------------------------------------------------------*/
                                         /* keine lokalen Variablen */
   /*=================================================================*/
  }

 /**====================================================================
  * Main-program AddPath
  *
  * Arguments:
  *       0 - Source-path-value to be added
  *       1 - Path to registry-container
  *       2 - Name of path-variable within registry(-container)
  *  Attention: The type of the entry must be defined as 'REG_SZ'
  *
  *  Attention; This programm uses the command 'REG' (Reg.exe) to
  *             manage the windows registry. This command must be
  *             available to successfully use this method.
  *
  * ##main (Eyecatcher)
  ====================================================================*/
  public static void main( /* start of program 'AddPath' */
   String[] args) /* current parameter */
   {
   /*-----------------------------------------------------------------*/
    Runtime        rt;    /* current Runtime-Environment */
    Process        aPr;   /* process of execution */
    BufferedReader PrOut; /* Message-Reader (responses) */
    String         data;  /* buffer */
    int            i;     /* pointer */
    String         is;    /* current command */
    String         rs,t;  /* result of registry-query, type of entry */
   /*=================================================================*/
    /* check specified parameter */
    if(args.length!=3) System.exit(5);
      /* invalid number of args -- terminate program */

    rt = Runtime.getRuntime(); /* get runtime-environment */
    t  = null; /* preset: no result */
    rs = null; /* preset: Compiler needs it */

    is = String.format("Reg QUERY \"%s\" /v \"%s\"",args[1],args[2]);
      /* create command (query) to search for current value */
// System.out.println("Command: '"+is+"'");
    try { /* try to execute command */
      aPr = rt.exec(is); /* do it */
      PrOut = new BufferedReader( /* get reader for responses */
        new InputStreamReader(aPr.getInputStream()));
      is = args[2].toUpperCase(); /* set name for index */
      while((data=PrOut.readLine())!=null) { /* lines present? */
// System.out.println("Line:'"+data+"'");
        if((i=data.toUpperCase().indexOf(is))<0) continue;
          /* real result-line must contain the variable-name  */
        i += is.length(); /* compute start of valid data */
        data = data.substring(i).trim(); /* delete leading blanks */
// System.out.println("Line(t):'"+data+"'");
        for(i=0;i<data.length();i+=1) if(Character.isWhitespace(data.charAt(i))) break;
        if(i>=data.length()) System.exit(2); /* error should not occur */
        t = data.substring(0,i); /* extract type of registry-entry */
        rs = data.substring(i).trim(); /* extract value, delete leading blanks */
// System.out.println("Line(x): Typ = '"+t+"', Val = '"+rs+"'");
      } /* response-lines present */
      i = aPr.waitFor(); /* wait until command finished and get return-code */
    } catch (Exception e) { /* error found while command-exec */
      System.err.println("Command-Error(1):"+e.toString());
      i = 20; /* set special return-code */
    } /* error occurred */
// System.out.println("Executing command RC = "+i);

    if(i>0){ /* no variable found / error -- check case */
      if(t!=null || rs!=null) rt.exit(i); /* error -- terminate program */
      t = "REG_SZ"; /* initialize type of entry */
      rs = "."; /* and set path to 'current directory ' */
    } /* valid path-definitions are available now */

    if(!t.equals("REG_SZ")) System.exit(3); /* no valid result available -- terminate */
    if(rs.toLowerCase().indexOf(args[0].toLowerCase())>=0) return; /* path already inserted */

    rs += ";" + args[0]; /* add new path to environment-variable */

    is = String.format("Reg ADD \"%s\" /v \"%s\" /t %s /d \"%s\" /f",args[1],args[2],t,rs);
      /* create command (add) to replace current value */
// System.out.println("Command: '"+is+"'");
    try { /* try to execute command */
      aPr = rt.exec(is); /* do it */
      PrOut = new BufferedReader( /* get reader for responses */
        new InputStreamReader(aPr.getInputStream()));
      while((data=PrOut.readLine())!=null); /* lines present? -- ignore */
      i = aPr.waitFor(); /* wait until command finished and get return-code */
    } catch (Exception e) { /* error found while command-exec */
      System.err.println("Command-error(2):"+e.toString());
      i = 25; /* set special return-code */
    } /* error occurred */

    rt.exit(i); /* OK -- terminate program */
  }

 /**==================================================================*/
}
