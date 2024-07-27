using System;
using System.Collections.Generic;

namespace QuanLiNhaHang.Models;

public partial class Question
{
    public int QuestionId { get; set; }

    public string QuestionName { get; set; } = null!;

    public virtual ICollection<Answer> Answers { get; set; } = new List<Answer>();
}
