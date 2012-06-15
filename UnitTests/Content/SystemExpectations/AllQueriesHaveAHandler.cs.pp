using System;
using System.Linq;
using System.Reflection;
using NUnit.Framework;
using ShortBus;
using Should;
using StructureMap.TypeRules;

namespace UnitTests.SystemExpectations
{
    [TestFixture]
    public class AllQueriesHaveAHandler
    {
        [Test]
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

                true.ShouldBeFalse(string.Format("no query handler for {0}", queryType.Name));
                
            }
        }

        private static Assembly GetAssembly(string name)
        {
            return AppDomain.CurrentDomain.GetAssemblies().Single(a => a.GetName().Name.Equals(name, StringComparison.CurrentCultureIgnoreCase));
        }
    }
}