using Should;

namespace UnitTests
{
    [TestClass]
    public class AlwaysPass
    {
        [TestMethod]
        public void Assert_true()
        {
            true.ShouldBeTrue();
        }
    }
}