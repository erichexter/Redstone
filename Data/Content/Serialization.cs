using Newtonsoft.Json;

namespace Data.Serialization
{
    /// <summary>
    ///     Thin wrapper around Newtonsoft.JSON
    /// </summary>
    public static class Json
    {
        public static string Serialize(object data)
        {
            return JsonConvert.SerializeObject(data);
        }

        public static T Deserialize<T>(string json)
        {
            return JsonConvert.DeserializeObject<T>(json);
        }
    }
}