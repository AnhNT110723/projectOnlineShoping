using Microsoft.EntityFrameworkCore;
using QuanLiNhaHang.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace QuanLiNhaHang.ViewModel.Customer
{
    public class QuestionCanelBookingTableViewModel : BaseViewModel
    {
        //private string _Questions;
        //public string Questions { get => _Questions; set { _Questions = value; OnPropertyChanged(); } }   

        //private ObservableCollection<string> _Answers;
        //public ObservableCollection<string> Answers { get => _Answers; set { _Answers = value; OnPropertyChanged(); } }

        private ObservableCollection<Question> _Questions;
        public ObservableCollection<Question> Questions
        {
            get => _Questions;
            set
            {
                _Questions = value;
                OnPropertyChanged();
            }
        }

        private string _SelectedAnswer;
        public string SelectedAnswer
        {
            get => _SelectedAnswer;
            set
            {
                _SelectedAnswer = value;
                OnPropertyChanged();
            }
        }

        private int? _selectedAnswerId;
        public int? SelectedAnswerId
        {
            get => _selectedAnswerId;
            set
            {
                _selectedAnswerId = value;
                OnPropertyChanged();
            }
        }

        public ICommand ConfirmCommand {  get; set; }
        public ICommand CancelCommand {  get; set; }

        public QuestionCanelBookingTableViewModel(int tableId)
        {
            ReadData();
            Confirm();
        }

        public void ReadData()
        {
            using (var context = new NhaHangProjectContext())
            {
                //var list = context.Questions.Select(x => x.QuestionName).FirstOrDefault();
                //Questions = list;

                //var answers = context.Answers
                //  .Select(a => a.AnswerText)
                //  .ToList();

                //Answers = new ObservableCollection<string>(answers);




                    var questions = context.Questions
                        .Include(q => q.Answers)
                        .ToList();

                    Questions = new ObservableCollection<Question>(questions);
                

            }
        }

        public void Confirm()
        {
            ConfirmCommand = new RelayCommand<object>((p) => { return true; }, (p) =>
            {
                // Handle confirmation logic here 
                if (SelectedAnswerId.HasValue)
                {
                    MessageBox.Show($"Selected Answer ID: {SelectedAnswerId}");
                    // Do something with the selected answer ID
                }
                else
                {
                    MessageBox.Show("No answer selected.");
                }
            });
        }
    }
}
