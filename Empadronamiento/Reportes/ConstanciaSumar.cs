using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DalSic.Utilidades;
using System.Web.UI.WebControls;
using DalSic;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using SubSonic;

namespace Empadronamiento.Reportes
{
    public class ConstanciaSumar
    {
        
        public ConstanciaSumar()
        {
        }

        public MemoryStream imprimirConstancia(int idPaciente)
        {
            SysPaciente p = new SysPaciente(idPaciente);

            CrystalReportSource oCr = new CrystalReportSource();
            string informe = "../Paciente/Reportes/certificadoSumar.rpt";
            
            DataTable dt = SPs.PnGetCertificadoSumar(p.NumeroDocumento.ToString()).GetDataSet().Tables[0];
            oCr.Report.FileName = informe;
            oCr.ReportDocument.SetDataSource(dt);
            oCr.DataBind();

            MemoryStream oStream;
            return oStream = (MemoryStream)oCr.ReportDocument.ExportToStream(ExportFormatType.PortableDocFormat);
            
        }

        
        public int insertarBeneficiario(int idPaciente)
        {
            int resultado = 0;
            
            DalSic.SysPaciente pac = new DalSic.SysPaciente(idPaciente);

            StoredProcedure sproc = SPs.PnInsertarPacienteEnPlanSumar(pac.IdPaciente,resultado);
            sproc.Execute();
            resultado = (int)sproc.OutputValues[0]; 
            //Devuelve un boolean si la inserción fue exitosa de acuerdo a las condiciones de Programa Sumar
            return resultado;
        }
        
    }
}