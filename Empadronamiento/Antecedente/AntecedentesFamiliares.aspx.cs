using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.IO;
using CrystalDecisions.Web;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using Salud.Security.SSO;
using DalSic;

namespace Empadronamiento.Antecedente
{
    public partial class AntecedentesFamiliares : System.Web.UI.Page
   
    {
        int vCuenta = 0;
        bool vChekError = false;
        int vABVD = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            //super sso

            if (!Page.IsPostBack)
            {
                if (Request["idPaciente"] != null)
                    TreeView1.ExpandAll();
                    lbExistenRegistros.Visible = false;

                    SysPaciente oPaciente = new SysPaciente(int.Parse(Request["idPaciente"].ToString()));
                    lPaciente.Text = oPaciente.Apellido + "  " + oPaciente.Nombre;
                if (oPaciente.IdEstado!=2 )
                    ldniPaciente.Text = oPaciente.NumeroDocumento.ToString();
                else

                ldniPaciente.Text = "Temporal";
                //definir tipo variable
                    if (Request["vCie10"] != null)
                    {
                        PanelAlta.Visible = true;
                        int vParentesco1 = int.Parse(Request["vParentesco"]);
                        int vCie101 = int.Parse(Request["vCie10"]);
                        ddlParentesco.SelectedValue = int.Parse(Request["vParentesco"]).ToString();
                        DiagnosticoPrincipal.setDiagnosticoPrincipal(vCie101);
                        btnEliminar.Visible = true;

                        //boton eliminar true si

                    }
 

                cargarCombos();
                int vPaciente = int.Parse(Request["idPaciente"]);

                DataTable dtDatosAtecedentes = new DataTable();
                dtDatosAtecedentes = SPs.SysParentescoT(vPaciente).GetDataSet().Tables[0];
                if (dtDatosAtecedentes.Rows.Count != 0) // existe al menos un registro
                {
                    Arbol();
                }
                else
                {
                    lbExistenRegistros.Visible = true;
                }
               Arbol();
                //TablaErrores.Visible = false;
            }
        }

        private void Arbol() 
        {
            TreeView1.ExpandAll();
            TreeNode nodo = new TreeNode();
            TreeView1.Nodes.Clear();
            nodo.Value = "0";
            nodo.Text = "Antecedentes Familiares";
            TreeView1.Nodes.Add(nodo);
         //   entonces para para cargar el renglon de abajo, dspues de ? de pregunta agregar una variable=valor&otravariable=otrovalor
            int vParentesco = int.Parse(ddlParentesco.SelectedValue.ToString());
            int vCIE10=DiagnosticoPrincipal.getDiagnostico();
            int vPaciente = int.Parse(Request["idPaciente"].ToString());
            //nodo.NavigateUrl = "AntecedentesFamiliares.aspx?Parentesco=" + vParentesco.ToString() + "&CIE10=" + vCIE10.ToString() + "&Paciente= " + vPaciente.ToString();
            //nodo.NavigateUrl = "Catastro.aspx?tipo=Habitacion&idHabitacion=" + nodo.Value;
            //nodo.NavigateUrl = "AntecedentesFamiliares.aspx?Parentesco=" + vParentesco.ToString() + "&CIE10=" + vCIE10.ToString() + "&Paciente= " + vPaciente.ToString();
            mostrarNodos(nodo);
       
            

         
  
        }

        private void mostrarNodos(TreeNode pad)
        {
                
            TreeView1.ExpandAll();
            int vPaciente = int.Parse(Request["idPaciente"]);
            DataSet dts = new DataSet();
            dts = SPs.SysParentescoT(vPaciente).GetDataSet();

            for (int i = 1; i <= dts.Tables[0].Rows.Count; i++)
            {
                string id = dts.Tables[0].Rows[i - 1]["id"].ToString();
                
                TreeNode nodo = new TreeNode();
                nodo.Text = dts.Tables[0].Rows[i - 1]["Nombre"].ToString()  ;
                nodo.Value = id;
                nodo.Expand();
                pad.ChildNodes.Add(nodo);
               mostrarNodosAntecedente(nodo,int.Parse(id));
            }
       
        }

        private void mostrarNodosAntecedente(TreeNode pad,int id)
        {
            int vPaciente = int.Parse(Request["idPaciente"]);

            //dtsP = SPs.SysPacAntFamiliares(cargarCombos idPaciente,int.Parse(Session["idParentesco"].ToString())).GetDataSet();
            DataSet dtsP = new DataSet();
            dtsP = SPs.SysPacAntecedentesFamiliares(vPaciente, id).GetDataSet();
            
            for (int i = 1; i <= dtsP.Tables[0].Rows.Count; i++)
            {
                
                string idA = dtsP.Tables[0].Rows[i - 1]["id"].ToString();

                TreeNode nodo = new TreeNode();
                nodo.Text = dtsP.Tables[0].Rows[i - 1]["DiagNombre"].ToString();
                nodo.Value = idA;

                nodo.Expand();
                pad.ChildNodes.Add(nodo);
               // btnGuardar.Text = nodo.Value;

               
                string vCie101= dtsP.Tables[0].Rows[i - 1]["idCie10"].ToString();

                nodo.NavigateUrl = "AntecedentesFamiliares.aspx?vParentesco=" + idA + "&vCie10=" + vCie101 + "&idPaciente=" + vPaciente.ToString();
                //nodo.NavigateUrl = "Catastro.aspx?tipo=Habitacion&idHabitacion=" + nodo.Value;
                
            }
        }

      


        private void cargarCombos()
        {
          
            ddlParentesco.DataSource = SPs.SysParentescoTb().GetDataSet().Tables[0];
            ddlParentesco.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            
            int vPaciente = int.Parse(Request["idPaciente"]);
            //if ((Page.IsValid) && (!hayError()))
            //{
                //int idVGIDatos = SubSonic.Sugar.Web.QueryString<int>("idVGIDatos");
                SysPacienteAntecedentesFamiliare oDato = new SysPacienteAntecedentesFamiliare();
                
                oDato.IdPaciente = vPaciente;
                oDato.IdParentesco = int.Parse(ddlParentesco.SelectedValue.ToString());
                //int i_Cie10 = DalSic.ConsultaAmbulatoria.UserControls.DiagnosticoPrincipal.getObraSocial();
                oDato.IdCie10 = DiagnosticoPrincipal.getDiagnostico();



                oDato.Id = (int.Parse(Request["idPaciente"].ToString()));
                //oDato.IdTurno = 21;
                    //oDato.IdPaciente = 318925;

                oDato.IdUsuarioCarga = SSOHelper.CurrentIdentity.Id;
                //oDato.IdUsuarioCarga = SSOHelper.CurrentIdentity.Id;
                oDato.FechaCarga = DateTime.Now;

                oDato.Save();
                Arbol();

                //Session["vsVolver"] = "ProsameEdit.aspx";
                //string url = "AntecedentesFamiliares.aspx?vPaciente=" + Request["idPaciente"].ToString().Trim();
                //Response.Redirect(url, false);
  
               //}
        }

        protected void BtnMasAntecedentes_Click(object sender, EventArgs e)
        {
            if (BtnMasAntecedentes.Text == "+")
                {
                    PanelAlta.Visible = true;
                    BtnMasAntecedentes.Text = "-";
                }
            else
                {
                    PanelAlta.Visible = false;
                    BtnMasAntecedentes.Text = "+";                
                   
                }
                
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            //int vPaciente = int.Parse(Request["idPaciente"]);
            string url = Session["vsVolver"].ToString().Trim();
            Response.Redirect(url, false);
            //string url 
         //   Response.Redirect(url, false);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
           
            int vParentesco = int.Parse(ddlParentesco.SelectedValue.ToString());
            int vCIE10 = DiagnosticoPrincipal.getDiagnostico();
            int vPaciente = int.Parse(Request["idPaciente"]);
            SPs.SysPacAntecedentesFamiliaresElimina(vPaciente, vParentesco, vCIE10).Execute();
            Arbol();
      }






           }
}