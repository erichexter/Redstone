using System.Data.Entity;
using Data.Model;
namespace Data
{
    public class DataModelContext : DbContext
    {
        public DbSet<EntityDataModel> Masthead { get; set; }

        public DataModelContext()
        {

        }

        public DataModelContext(string connectionStringName)
        {

        }

    }
}
