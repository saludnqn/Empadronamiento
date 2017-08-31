using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DalSic;

namespace Empadronamiento {
    public partial class ValidarOS : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                int id = SubSonic.Sugar.Web.QueryString<int>("id");
                if (id > 0) {
                    SysPaciente p = new SysPaciente(id);
                    // verifico que no tenga OS y si tiene
                    // que sea distinta de plan nacional
                    if (!(p.IdObraSocial > 0 && p.SysObraSocial.IdTipoObraSocial != 3)) {
                        VerificarPlanNacer(p);
                        VerificarRemediarRedes(p);
                    } else {
                        Response.Redirect("PacienteList.aspx", false);
                    }
                }
            }
        }

        private void VerificarPlanNacer(SysPaciente p) {
            PnBeneficiarioCollection benef = DB.Select().From(Schemas.PnBeneficiario)
                .Where(PnBeneficiario.Columns.IdPaciente).IsEqualTo(p.IdPaciente)
                .ExecuteAsCollection<PnBeneficiarioCollection>();
            if (benef.Count > 0) {
                hlPlanNacer.Text = "Ver beneficiario";
                hlPlanNacer.NavigateUrl = string.Format("~/PlanNacer/Inscripcion/View.aspx?id={0}", benef[0].IdBeneficiarios);
            } else {
                if (CumpleCondicionesPlanNacer(p)) {
                    hlPlanNacer.Text = "Inscribir como beneficiario";
                    hlPlanNacer.NavigateUrl = string.Format("~/PlanNacer/Inscripcion/Edit.aspx?idPac={0}", p.IdPaciente);
                    hlPlanNacer.Enabled = true;
                } else {
                    hlPlanNacer.Text = "No cumple las condiciones de Plan Nacer";
                    hlPlanNacer.NavigateUrl = "#";
                    hlPlanNacer.Enabled = false;
                }
            }
        }

        private void VerificarRemediarRedes(SysPaciente p) {
            //RemFormularioCollection benef = DB.Select().From(Schemas.RemFormulario)
            //    .Where(RemFormulario.Columns.IdPaciente).IsEqualTo(p.IdPaciente)
            //    .ExecuteAsCollection<RemFormularioCollection>();
            //if (benef.Count > 0) {
            //    hlRemediarRedes.Text = "Ver Ficha";
            //    hlRemediarRedes.NavigateUrl = string.Format("~/RemediarRedes/Preclasificacion/ver.aspx?id={0}", benef[0].IdFormulario);
            //} else {
            //    if (CumpleCondicionesRemediarRedes(p)) {
            //        hlRemediarRedes.Text = "Cargar como beneficiario";
            //        hlRemediarRedes.NavigateUrl = string.Format("~/RemediarRedes/Preclasificacion/Editar.aspx");
            //        hlRemediarRedes.Enabled = true;
            //    } else {
            //        hlRemediarRedes.Text = "No cumple las condiciones de Remediar Redes";
            //        hlRemediarRedes.NavigateUrl = "#";
            //        hlRemediarRedes.Enabled = false;
            //    }
            //}
        }

        private bool CumpleCondicionesPlanNacer(SysPaciente p) {
            switch (p.IdSexo) {
                case 2: // femenino
                    return p.Edad <= 64;
                case 3: // masculino
                    return p.Edad <= 18;
                default:
                    return false;
            }
        }

        private bool CumpleCondicionesRemediarRedes(SysPaciente p) {
            return p.Edad >= 18;
        }
    }
}
