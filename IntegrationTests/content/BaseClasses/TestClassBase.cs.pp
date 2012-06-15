using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using Data;
using NUnit.Framework;
using StructureMap;

namespace IntegrationTests.BaseClasses
{
    [TestFixture]
    public class TestClassBase
    {
        const string SQL_COMPACT_CONNECTION_STRING = "DataModelContext.sdf";
        static IContainer ApplicationContainer;
        static IContainer TestContainer;

        [SetUp]
        public static void AssemblyInit(TestContext unused)
        {
            ApplicationContainer = IoC.Initialize();

            Database.DefaultConnectionFactory = new SqlCeConnectionFactory("System.Data.SqlServerCe.4.0");
            DeleteDatabase();
        }

        public static void WithDbContext(Action<DataModelContext> action)
        {
            using (var context = new DataModelContext(SQL_COMPACT_CONNECTION_STRING))
            {
                if (action != null)
                {
                    action(context);
                }
            }
        }

        protected static void DeleteDatabase()
        {
            WithDbContext(x =>
                {
                    if (x.Database.Exists())
                        x.Database.Delete();
                });
        }

        protected static void ClearDatabase()
        {
            WithDbContext(x =>
                {
                    //x.Database.ExecuteSqlCommand("delete from Entities");
                });
        }

        /// <summary>
        ///     Must call this in ClassInitialize
        /// </summary>
        public static void Initialize()
        {
            TestContainer = ApplicationContainer.GetNestedContainer();

            //Inject<IUrlResolver>(new StubUrlResolver());
        }

        protected static T GetInstance<T>()
        {
            return TestContainer.GetInstance<T>();
        }

        protected static void Inject<T>(T instance)
        {
            TestContainer.Configure(cfg => cfg.For<T>().Use(instance));
        }
    }
}