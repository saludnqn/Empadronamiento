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
    /// Controller class for APR_CondicionIngreso
    /// </summary>
    [System.ComponentModel.DataObject]
    public partial class AprCondicionIngresoController
    {
        // Preload our schema..
        AprCondicionIngreso thisSchemaLoad = new AprCondicionIngreso();
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
        public AprCondicionIngresoCollection FetchAll()
        {
            AprCondicionIngresoCollection coll = new AprCondicionIngresoCollection();
            Query qry = new Query(AprCondicionIngreso.Schema);
            coll.LoadAndCloseReader(qry.ExecuteReader());
            return coll;
        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public AprCondicionIngresoCollection FetchByID(object IdCondicionAlIngreso)
        {
            AprCondicionIngresoCollection coll = new AprCondicionIngresoCollection().Where("idCondicionAlIngreso", IdCondicionAlIngreso).Load();
            return coll;
        }
		
		[DataObjectMethod(DataObjectMethodType.Select, false)]
        public AprCondicionIngresoCollection FetchByQuery(Query qry)
        {
            AprCondicionIngresoCollection coll = new AprCondicionIngresoCollection();
            coll.LoadAndCloseReader(qry.ExecuteReader()); 
            return coll;
        }
        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public bool Delete(object IdCondicionAlIngreso)
        {
            return (AprCondicionIngreso.Delete(IdCondicionAlIngreso) == 1);
        }
        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public bool Destroy(object IdCondicionAlIngreso)
        {
            return (AprCondicionIngreso.Destroy(IdCondicionAlIngreso) == 1);
        }
        
        
    	
	    /// <summary>
	    /// Inserts a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Insert, true)]
	    public void Insert(string Nombre)
	    {
		    AprCondicionIngreso item = new AprCondicionIngreso();
		    
            item.Nombre = Nombre;
            
	    
		    item.Save(UserName);
	    }
    	
	    /// <summary>
	    /// Updates a record, can be used with the Object Data Source
	    /// </summary>
        [DataObjectMethod(DataObjectMethodType.Update, true)]
	    public void Update(int IdCondicionAlIngreso,string Nombre)
	    {
		    AprCondicionIngreso item = new AprCondicionIngreso();
	        item.MarkOld();
	        item.IsLoaded = true;
		    
			item.IdCondicionAlIngreso = IdCondicionAlIngreso;
				
			item.Nombre = Nombre;
				
	        item.Save(UserName);
	    }
    }
}
