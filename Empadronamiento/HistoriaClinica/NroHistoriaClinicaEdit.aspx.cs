using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using DalSic;
using Salud.Security.SSO;

namespace DalSic.HistoriaClinica
{
    public partial class NroHistoriaClinicaEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //cuando es una edicion el idPaciente = 0
                int idPac = SubSonic.Sugar.Web.QueryString<int>("idPac");
                int idRel = SubSonic.Sugar.Web.QueryString<int>("idRel");
                lblHc.Text = "";
                txtHC.Focus();
                if (idPac > 0)
                {
                    SysPaciente pac = new SysPaciente(idPac);
                    CargarPaciente(pac);
                    CargarHC(pac, SSOHelper.CurrentIdentity.IdEfector);

                    DataTable mhc = SPs.SysGetUltimaHC(SSOHelper.CurrentIdentity.IdEfector).GetDataSet().Tables[0];
                    lblHc.Text = "Próximo número de Historia Clínica sugerida para el efector: " + mhc.Rows[0][0].ToString();
                }
                if (idRel > 0)
                {
                    SysRelHistoriaClinicaEfector hc = new SysRelHistoriaClinicaEfector(idRel);
                    if (!hc.IsNew)
                    {
                        CargarPaciente(hc.SysPaciente);
                        txtHC.Text = hc.HistoriaClinica.ToString();
                        hfIdRel.Value = hc.IdRelHistoriaClinicaEfector.ToString();
                    }
                }

            }
        }

        private void CargarHC(SysPaciente pac, int idEfector)
        {
            List<SysRelHistoriaClinicaEfector> l = pac.SysRelHistoriaClinicaEfectorRecords.Where(x => x.IdEfector == idEfector).ToList<SysRelHistoriaClinicaEfector>();
            if (l.Count > 0)
            {
                txtHC.Text = l[0].HistoriaClinica.ToString();
                hfIdRel.Value = l[0].IdRelHistoriaClinicaEfector.ToString();
            }
            else
            {
                txtHC.Text = "";
                hfIdRel.Value = "0";
            }
        }

        private void CargarPaciente(SysPaciente pac)
        {
            lblDoc.Text = pac.NumeroDocumento.ToString();
            lblApellido.Text = pac.Apellido;
            lblNombres.Text = pac.Nombre;
            lblFNac.Text = pac.FechaNacimiento.ToShortDateString();
            lblSexo.Text = pac.SysSexo.Nombre;
            lblContacto.Text = pac.InformacionContacto.ToString();
            hfidPac.Value = pac.IdPaciente.ToString();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string usuario = SSOHelper.CurrentIdentity.Username;            
            int id = Convert.ToInt32(hfIdRel.Value); /**/
            int idCama = 0;
            if (Request["IdCama"] != null)
                idCama = int.Parse(Request["IdCama"].ToString());
            if (DatoValido(id))
            {
                SysRelHistoriaClinicaEfector rhc = new SysRelHistoriaClinicaEfector(id);
                rhc.IdEfector = SSOHelper.CurrentIdentity.IdEfector;
                rhc.HistoriaClinica = Convert.ToInt32(txtHC.Text);
                rhc.IdPaciente = Convert.ToInt32(hfidPac.Value);
                rhc.IdUsuarioRegistro = usuario;
                rhc.FechaRegistro = DateTime.Now;
                rhc.Save(usuario);

                if (Request.QueryString["llamadaDesde"] == "Internacion")
                {
                    string strDalSic = SSOHelper.Configuration["Domain"] as string;
                    Response.Redirect("../../Internacionhospital/Ingresos/IngresoEdit.aspx?idPaciente=" + rhc.IdPaciente + "&idCama=" + idCama, false);
                }
                else
                    Response.Redirect("NroHistoriaClinicaView.aspx?idRel=" + rhc.IdRelHistoriaClinicaEfector.ToString());
            }
        }

        private bool DatoValido(int idRel)
        {
            int idPac = Convert.ToInt32(hfidPac.Value);
            lblMensaje.Text = string.Empty;

            if (!string.IsNullOrEmpty(txtHC.Text))
            {
                int nro = Convert.ToInt32(txtHC.Text);
                SubSonic.Select p = new SubSonic.Select();
                p.From(SysRelHistoriaClinicaEfector.Schema);
                p.Where(SysRelHistoriaClinicaEfector.Columns.IdEfector).IsEqualTo(SSOHelper.CurrentIdentity.IdEfector);
                p.And(SysRelHistoriaClinicaEfector.Columns.HistoriaClinica).IsEqualTo(nro);
                p.And(SysRelHistoriaClinicaEfector.Columns.IdPaciente).IsNotEqualTo(idPac);
                p.And(SysRelHistoriaClinicaEfector.Columns.HistoriaClinica).IsNotEqualTo(0);
                DataTable dt = p.ExecuteDataSet().Tables[0];
                if (dt.Rows.Count > 0)
                {
                    lblMensaje.Text = "El Número de Historia Clínica ya existe en el Efector. <br/>";
                    return false;
                }
            }
            else
            {
                lblMensaje.Text = "Debe ingresar un número válido de Historia Clínica.";
                return false;
            }
            if (lblMensaje.Text == string.Empty)
            {
                return true;
            }
            else
                return false;
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

            lblMensaje.Text = "";
            lblHc.Text = "";
            if ((!string.IsNullOrEmpty(txtDni.Text)) && (txtDni.Text.Length > 5))
            {
                int bus = Convert.ToInt32(txtDni.Text);
                //Busqueda en Sys_Paciente
                DataTable dtpac = SPs.SysGetPacientesHC(bus, SSOHelper.CurrentIdentity.IdEfector).GetDataSet().Tables[0];
                if (dtpac.Rows.Count > 0)
                {
                    lblDoc.Text = dtpac.Rows[0][3].ToString();
                    lblApellido.Text = dtpac.Rows[0][1].ToString();
                    lblNombres.Text = dtpac.Rows[0][2].ToString();
                    lblSexo.Text = dtpac.Rows[0][4].ToString();
                    lblFNac.Text = dtpac.Rows[0][6].ToString();
                    lblContacto.Text = dtpac.Rows[0][8].ToString();
                    txtHC.Text = dtpac.Rows[0][9].ToString();
                    hfidPac.Value = dtpac.Rows[0][0].ToString();
                    hfIdRel.Value = dtpac.Rows[0][11].ToString();
                }
                else
                {
                    lblMensaje.Text = "El paciente buscado no posee Nro de Historia Clinica en el efector";
                    limpiarControles();
                    //aca debo traer los datos del paciente igual
                    DataTable pac = SPs.GetPacientesPorDocumento(bus).GetDataSet().Tables[0];
                    if (pac.Rows.Count > 0)
                    {
                        lblDoc.Text = pac.Rows[0][5].ToString();
                        lblApellido.Text = pac.Rows[0][3].ToString();
                        lblNombres.Text = pac.Rows[0][4].ToString();
                        lblSexo.Text = pac.Rows[0][6].ToString();
                        lblFNac.Text = pac.Rows[0][8].ToString();
                        lblContacto.Text = pac.Rows[0][9].ToString();
                        txtHC.Text = "";
                        hfidPac.Value = pac.Rows[0][0].ToString();
                        hfIdRel.Value = "0";

                        DataTable mhc = SPs.SysGetUltimaHC(SSOHelper.CurrentIdentity.IdEfector).GetDataSet().Tables[0];
                        lblHc.Text = "Próximo número de Historia Clínica sugerida para el efector: " + mhc.Rows[0][0].ToString();
                    }
                    else
                    {
                        lblMensaje.Text = "No se encontró al paciente buscado, deberá ingresarlo";
                        limpiarControles();
                    }
                }
            }
            else lblMensaje.Text = "Debe ingresar un numero válido.";
        }

        private void limpiarControles()
        {
            lblDoc.Text = "";
            lblApellido.Text = "";
            lblNombres.Text = "";
            lblSexo.Text = "";
            lblFNac.Text = "";
            lblContacto.Text = "";
            txtHC.Text = "";
            txtDni.Text = "";
            hfidPac.Value = "";
            hfIdRel.Value = "";
        }
    }
}
