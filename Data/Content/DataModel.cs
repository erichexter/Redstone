using System;
using System.ComponentModel.DataAnnotations;
using Data.Serialization;

namespace Data
{
    public abstract class DataModel<TData>
    {
        protected DataModel() { }

        protected DataModel(string key, TData data)
        {
            Key = key;
            serialize(data);
        }

        [Key]
        public string Key { get; protected set; }

        public string Data { get; set; }

        public void Update(Action<TData> updateAction)
        {
            var data = GetData();

            if (updateAction != null)
            {
                updateAction(data);
            }

            SetData(data);
        }

        public TData GetData()
        {
            return deserialize<TData>();
        }

        public TDerived GetDerivedData<TDerived>() where TDerived : TData
        {
            return deserialize<TDerived>();
        }

        public void SetData(TData data)
        {
            serialize(data);
        }

        TSerialized deserialize<TSerialized>()
        {
            if (string.IsNullOrWhiteSpace(Data))
            {
                return default(TSerialized);
            }
            return Json.Deserialize<TSerialized>(Data);
        }

        void serialize(TData data)
        {
            Data = Json.Serialize(data);
        }
     }
}