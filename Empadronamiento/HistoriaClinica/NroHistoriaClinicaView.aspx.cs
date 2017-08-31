using System;
using System.Collections.Generic;
using DalSic;
using Salud.Security.SSO;

namespace DalSic.HistoriaClinica
{
    public partial class NroHistoriaClinicaView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
                int idPac = SubSonic.Sugar.Web.QueryString<int>("idPaciente");
                int idRel = SubSonic.Sugar.Web.QueryString<int>("idRel");
                if (!IsPostBack)
                {
                    if (idPac > 0)
                    {
                        SysPaciente pac = new SysPaciente(idPac);
                        CargarPaciente(pac);
                        hfIdPaciente.Value = idPac.ToString();
                    }
                    if (idRel > 0)
                    {
                        SysRelHistoriaClinicaEfector hc = new SysRelHistoriaClinicaEfector(idRel);
                        CargarPaciente(hc.SysPaciente);
                        lbltHC.Text = hc.HistoriaClinica.ToString();
                        lblFecha.Text = hc.FechaRegistro.ToShortDateString();
                    }
                }            
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            int idRel = SubSonic.Sugar.Web.QueryString<int>("idRel");
            if (idRel > 0)
            {
                SysRelHistoriaClinicaEfector rhc = new SysRelHistoriaClinicaEfector(idRel);
                Response.Redirect("NroHistoriaClinicaEdit.aspx?idRel=" + rhc.IdRelHistoriaClinicaEfector.ToString());
            }
            else
            {
                int idPac = SubSonic.Sugar.Web.QueryString<int>("idPaciente");
                if (idPac > 0)
                {
                    Response.Redirect("NroHistoriaClinicaEdit.aspx?idPac=" + idPac.ToString());
                }
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
            SubSonic.Select q = new SubSonic.Select();
            q.From(SysRelHistoriaClinicaEfector.Schema);
            q.Where(SysRelHistoriaClinicaEfector.Columns.IdPaciente).IsEqualTo(pac.IdPaciente);
            q.And(SysRelHistoriaClinicaEfector.Columns.IdEfector).IsEqualTo(SSOHelper.CurrentIdentity.IdEfector);
            List<SysRelHistoriaClinicaEfector> lista = q.ExecuteTypedList<SysRelHistoriaClinicaEfector>();

            if (lista.Count > 0) {
                lblFecha.Text = lista[0].FechaRegistro.ToShortDateString();
                lbltHC.Text = lista[0].HistoriaClinica.ToString();
            }
            
           }

        protected void btnVolverPaciente_Click(object sender, EventArgs e)
        {
            int idRel = SubSonic.Sugar.Web.QueryString<int>("idRel");
            SysRelHistoriaClinicaEfector rhc = new SysRelHistoriaClinicaEfector(idRel);
            Response.Redirect("~/Paciente/PacienteEdit.aspx?id=" + rhc.IdPaciente.ToString());
        }
    }
}
