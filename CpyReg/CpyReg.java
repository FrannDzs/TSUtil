/**=================================================================<br>
 * Project     : TS
 * Program     : CpyReg.java
 * Stand       : 00.00.2011 (compare to file-date)
 * Version     : J3.x
 * Modul-ID    : -none-
 *
 * Description : Get value from registry and copy it to a special
 *                 registry-key to be used as an environment-variable
 * Remark      :  -none-
 *
 =====================================================================*/
import java.io.*;
import java.util.*;
/**=====================================================================
 * Class CpyReg
 * ##CpyReg (Eyecatcher)
 =====================================================================*/
public class CpyReg implements Serializable { /* Set variable (Basis) */
 /*-------------------------------------------------------------------*/
  protected static final String Version = "1.2.00"; /* akt. Version */
 /*-------------------------------------------------------------------*/
  protected static final String          tx1   = "Reg QUERY \"";
  protected static final String          tx2   = "\" /v \"";
  protected static final String          tx3   = "Reg ADD \"";
  protected static final String          tx4   = "\" /t ";
  protected static final String          tx5   = " /d \"";
  protected static final String          tx6   = "\" /f";
 /**====================================================================
  * Constructor: (1) create default-entry
  ====================================================================*/
  public CpyReg() /* Constructor is not explicitely used */
   {
   /*-----------------------------------------------------------------*/
                                         /* keine lokalen Variablen */
   /*=================================================================*/
  }

 /**====================================================================
  * Main-program CpyReg
  *
  * Arguments:
  *       0 - Source-path to registry-container
  *       1 - Name of variable within registry (source)
  *       2 - Destination-path to registry-container
  *       3 - Name of variable within registry (destination)
  *  If destination-name is not provided, source-name is used.
  *  If Source-path is specified as '*'
  *      - the 'value itself' is specified instead of the source-name
  *      - the type of the entry defaults to 'REG_SZ'
  *      - the destination-name MUST be provided
  *
  *  Attention; This programm uses the command 'REG' (Reg.exe) to
  *             manage the windows registry. This command must be
  *             available to successfully use this method.
  *
  * ##main (Eyecatcher)
  ====================================================================*/
  public static void main( /* start of program 'CpyReg' */
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
    if(args.length<3 || args.length>4) System.exit(5);
      /* invalid number of args -- terminate program */

    rt = Runtime.getRuntime(); /* get runtime-environment */
    t  = null; /* preset: no result */
    rs = null; /* preset: no result */
    if(args[0].equals("*")) { /* Value must be set from arguments */
      if(args.length==3) System.exit(7); /* all arguments are needed */
      t = "Reg_SZ"; /* set type of entry */
      rs = args[1]; /* and copy new value of entry */
    } else { /* value has to be read from Registry */
      is = tx1 + args[0] + tx2 + args[1] + "\""; /* create command (query) */
      try { /* try to execute command */
        aPr = rt.exec(is); /* do it */
        PrOut = new BufferedReader( /* get reader for responses */
          new InputStreamReader(aPr.getInputStream()));
        is = args[1].toUpperCase(); /* set name for index */
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
        System.err.println("Fehler:"+e.toString());
        i = 20; /* set special return-code */
      } /* error occurred */
// System.out.println("Command: '"+is+"', RC = "+i);
      if(i>0) rt.exit(i); /* error -- terminate program */
    } /* value has been read from Registry */

    if(t==null) System.exit(1); /* no result available -- terminate */

    if(t.equalsIgnoreCase("Reg_Multi_SZ")) rs = rs.substring(0,rs.length()-4);
      /* remove end-of-string characters '\0\0' */

    is = tx3 + args[2] + tx2 +    /* create second command (add) */
      ((args.length==4) ? args[3] : args[1]) + tx4 + t + tx5 + rs + tx6;
// System.out.println("Cmd:'"+is+"'");
    try { /* try to execute command */
      aPr = rt.exec(is); /* do it */
      PrOut = new BufferedReader( /* get reader for responses */
        new InputStreamReader(aPr.getInputStream()));
      while((data=PrOut.readLine())!=null); /* lines present? -- ignore */
      i = aPr.waitFor(); /* wait until command finished and get return-code */
    } catch (Exception e) { /* error found while command-exec */
      System.err.println("Fehler:"+e.toString());
      i = 25; /* set special return-code */
    } /* error occurred */

    rt.exit(i); /* OK -- terminate program */
  }

 /**==================================================================*/
}
