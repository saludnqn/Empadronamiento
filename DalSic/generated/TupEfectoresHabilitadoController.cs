using System; 
using System.Text; 
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration; 
using System.Xml; 
using System.Xml.Serialization;
using SubSonic; 
using SubSonic.Utilities;
namespace DalSic
{
    /// <summary>
    /// Controller class for TUP_EfectoresHabilitados
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class TupEfectoresHabilitadoController
    {
        // Preload our schema..
        TupEfectoresHabilitado thisSchemaLoad = new TupEfectoresHabilitado();
        private string userName = String.Empty;
        protected string UserName
        {
            get
            {
				if (userName.Length == 0) 
				{
    				if (System.Web.HttpContext.Current != null)
    				{
						userName=System.Web.HttpContext.Current.User.Identity.Name;
					}
					else
					{
						userName=System.Threading.Thread.CurrentPrincipal.Identity.Name;
					}
				}
				return userName;
            }
        }
        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public TupEfectoresHabilitadoCollection FetchAll()
        {
            TupEfectoresHabilitadoCollection coll = new TupEfectoresHabilitadoCollection();
            Query qry = new Query(TupEfectoresHabilitado.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public TupEfectoresHabilitadoCollection FetchByID(object IdEfectorHabilitado)
        {
            TupEfectoresHabilitadoCollection coll = new TupEfectoresHabilitadoCollection().Where("idEfectorHabilitado", IdEfectorHabilitado).Load();
            return coll;
        }
		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public TupEfectoresHabilitadoCollection FetchByQuery(Query qry)
        {
            TupEfectoresHabilitadoCollection coll = new TupEfectoresHabilitadoCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }
        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object IdEfectorHabilitado)
        {
            return (TupEfectoresHabilitado.Delete(IdEfectorHabilitado) == 1);
        }
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object IdEfectorHabilitado)
        {
            return (TupEfectoresHabilitado.Destroy(IdEfectorHabilitado) == 1);
        }
        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(int IdEfector)
	    {
		    TupEfectoresHabilitado item = new TupEfectoresHabilitado();
		    
            item.IdEfector = IdEfector;
            
	    
		    item.Save(UserName);
	    }
    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int IdEfectorHabilitado,int IdEfector)
	    {
		    TupEfectoresHabilitado item = new TupEfectoresHabilitado();
	        item.MarkOld();
	        item.IsLoaded = true;
		    
			item.IdEfectorHabilitado = IdEfectorHabilitado;
				
			item.IdEfector = IdEfector;
				
	        item.Save(UserName);
	    }
    }
}
