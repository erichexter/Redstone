using NUnit.Framework;
using Should;

namespace UnitTests
{
    [TestFixture]
    public class AlwaysPass
    {
        [Test]
        public void Assert_true()
        {
            true.ShouldBeTrue();
        }
    }
}