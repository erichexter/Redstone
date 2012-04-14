using System;
using System.ComponentModel.DataAnnotations;
using Data.Serialization;
namespace Data.Model
{
    public class EntityDataModel
    {
        [Key]
        public string Key { get; protected set; }
        public string EntityType { get; set; }
        public string Data { get; set; }
         
    }
}