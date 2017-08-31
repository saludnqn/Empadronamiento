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
    /// Controller class for Sys_TipoObraSocial
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class SysTipoObraSocialController
    {
        // Preload our schema..
        SysTipoObraSocial thisSchemaLoad = new SysTipoObraSocial();
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
        public SysTipoObraSocialCollection FetchAll()
        {
            SysTipoObraSocialCollection coll = new SysTipoObraSocialCollection();
            Query qry = new Query(SysTipoObraSocial.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public SysTipoObraSocialCollection FetchByID(object IdTipoObraSocial)
        {
            SysTipoObraSocialCollection coll = new SysTipoObraSocialCollection().Where("idTipoObraSocial", IdTipoObraSocial).Load();
            return coll;
        }
		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public SysTipoObraSocialCollection FetchByQuery(Query qry)
        {
            SysTipoObraSocialCollection coll = new SysTipoObraSocialCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }
        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object IdTipoObraSocial)
        {
            return (SysTipoObraSocial.Delete(IdTipoObraSocial) == 1);
        }
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object IdTipoObraSocial)
        {
            return (SysTipoObraSocial.Destroy(IdTipoObraSocial) == 1);
        }
        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(string Nombre)
	    {
		    SysTipoObraSocial item = new SysTipoObraSocial();
		    
            item.Nombre = Nombre;
            
	    
		    item.Save(UserName);
	    }
    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int IdTipoObraSocial,string Nombre)
	    {
		    SysTipoObraSocial item = new SysTipoObraSocial();
	        item.MarkOld();
	        item.IsLoaded = true;
		    
			item.IdTipoObraSocial = IdTipoObraSocial;
				
			item.Nombre = Nombre;
				
	        item.Save(UserName);
	    }
    }
}