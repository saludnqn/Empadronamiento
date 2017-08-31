using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DalSic;
using Salud.Security.SSO;
using System.IO;
using CrystalDecisions.Web;
using ExtensionMethods;
using CrystalDecisions.Shared;


namespace Empadronamiento
{
    public partial class PacienteReporte : System.Web.UI.Page
    {
        public CrystalReportSource oCr = new CrystalReportSource();

        protected void Page_PreInit(object sender, EventArgs e)
        {
            oCr.Report.FileName = "";
            oCr.CacheDuration = 0;
            oCr.EnableCaching = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtApellidoBusqueda.Focus();
                CargarCombos();
                txtFInicio.Text = DateTime.Now.ToShortDateString();
                txtFFin.Text = DateTime.Now.AddDays(10).ToShortDateString();
                lblMensaje.Text = "";
            }
        }

        private void CargarCombos()
        {
            SubSonic.Select ef = new SubSonic.Select();
            ef.From(SysEfector.Schema);
            //ef.Where(SysEfector.Columns.IdZona).IsEqualTo(9);
            ef.OrderAsc("nombre");
            ddlEfector.DataSource = ef.ExecuteTypedList<SysEfector>();
            ddlEfector.DataBind();
            ddlEfector.Items.Insert(0, new ListItem("TODOS", "0"));

            SubSonic.Select e = new SubSonic.Select();
            e.From(SysEstado.Schema);
            List<SysEstado> estados = e.ExecuteTypedList<SysEstado>();
            ddlEstado.DataSource = estados;
            ddlEstado.DataBind();
            ddlEstado.Items.Insert(0, new ListItem("TODOS", "0"));

            SubSonic.Select s = new SubSonic.Select();
            s.From(SysSexo.Schema);
            List<SysSexo> sexos = s.ExecuteTypedList<SysSexo>();
            ddlSexo.DataSource = sexos;
            ddlSexo.DataBind();
            ddlSexo.Items.Insert(0, new ListItem("TODOS", "0"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            //busqueda
            int efector = (ddlEfector.SelectedValue).TryParseInt(0);
            string apellido = txtApellidoBusqueda.Text;
            int sexo = (ddlSexo.SelectedValue).TryParseInt(0);
            int estado = (ddlEstado.SelectedValue).TryParseInt(0);
            DateTime? finicio = null; //fecha inicio de turno
            DateTime? ffin = null; //fecha de fin de turno
            DateTime inicio;
            DateTime fin;
            if (DateTime.TryParse(txtFInicio.Text, out inicio))
                finicio = inicio;
            if (DateTime.TryParse(txtFFin.Text, out fin))
                ffin = fin;

            DataTable ds = SPs.GetPacientesReporte(efector, apellido, sexo, estado, finicio, ffin).GetDataSet().Tables[0];
            if (ds.Rows.Count > 0)
            {
                gvPacientes.DataSource = ds;
                lblEncontrados.Visible=true;
                lblMensaje.Text = ds.Rows.Count.ToString();
                
            }
            gvPacientes.DataBind();
        }

        protected void gvPacientes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (DataBinder.Eval(e.Row.DataItem, "estado").ToString())
                {
                    case "Identificado":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#F0AD4E"); //System.Drawing.Color.LightBlue;
                        e.Row.ToolTip = "Pacientes Identificados";
                        break;
                    case "Temporal":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#D9534F");//System.Drawing.Color.AliceBlue;
                        e.Row.ToolTip = "Pacientes Temporales";
                        break;
                    case "Validado":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#5CB85C");//System.Drawing.Color.LightGoldenrodYellow;
                        e.Row.ToolTip = "Pacientes Validados";
                        break;
                    case "Inactivo":
                        e.Row.BackColor = System.Drawing.Color.Azure;
                        e.Row.ToolTip = "Pacientes Inactivos";
                        break;
                    default:
                        e.Row.BackColor = System.Drawing.Color.White;
                        break;
                }
            }
        }

        protected void gvPacientes_PageIndexChangind(object sender, GridViewPageEventArgs e)
        {
            btnBuscar_Click(null, null);
            gvPacientes.PageIndex = e.NewPageIndex;
            gvPacientes.DataBind();
        }


        protected void gridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dataTable = gvPacientes.DataSource as DataTable;

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);
                gvPacientes.DataSource = dataView;
                gvPacientes.DataBind();
            }
        }

        private string ConvertSortDirectionToSql(System.Web.UI.WebControls.SortDirection sortDirection)
        {
            string newSortDirection = String.Empty;

            switch (sortDirection)
            {
                case System.Web.UI.WebControls.SortDirection.Ascending:
                    newSortDirection = "ASC";
                    break;
                case System.Web.UI.WebControls.SortDirection.Descending:
                    newSortDirection = "DESC";
                    break;
            }
            return newSortDirection;
        }

    }
}

