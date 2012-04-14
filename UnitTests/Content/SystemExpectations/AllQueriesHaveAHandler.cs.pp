using System;
using System.Linq;
using System.Reflection;
using ShortBus;
using StructureMap.TypeRules;

namespace UnitTests.SystemExpectations
{
    [TestClass]
    public class AllQueriesHaveAHandler
    {
        [TestMethod]
        public void All_query_objects_should_have_a_handler()
        {
            var queryTypes = GetAssembly("core").GetTypes().Where(
                    type => type.ImplementsInterfaceTemplate(typeof(IQuery<>)));

            var queryhandlerDerivedTypes = GetAssembly("data").GetTypes().Where(
                    type => type.ImplementsInterfaceTemplate(typeof(IQueryHandler<,>))).ToArray();

            foreach (var queryType in queryTypes)
            {
                var queryHandlerTypes = queryhandlerDerivedTypes.Select(x => x.GetInterfaces()[0]);

                if (queryHandlerTypes.Any(x => x.GetGenericArguments()[0] == queryType))
                    continue;

                Assert.Fail("no query handler for {0}", queryType.Name);
            }
        }

        private static Assembly GetAssembly(string name)
        {
            return AppDomain.CurrentDomain.GetAssemblies().Single(a => a.GetName().Name.Equals(name, StringComparison.CurrentCultureIgnoreCase));
        }
    }
}