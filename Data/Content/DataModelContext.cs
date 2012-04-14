using System.Data.Entity;

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
