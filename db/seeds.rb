User.create!([
  {email: "admin@admin.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2018-03-09 23:23:10", last_sign_in_at: "2018-03-09 11:12:55", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "Administrator", role: "admin"},
  {email: "member@member.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2018-03-10 03:29:15", last_sign_in_at: "2018-03-09 10:54:26", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "Member", role: "member"}
])
Category.create!([
  {
    name: "All About Jakarta", 
    description: "<p>All questions will be about Jakarta as the capital city of Indonesia.</p>", 
    image: Rails.root.join("public/images/jakarta.jpg").open,
    published: true
  },
  {
    name: "Joko Widodo The President of Indonesia", 
    description: "<p>He is known by the name Jokowi. We have some interesting questions about his history. Dare to try it?</p>\r\n", 
    image: Rails.root.join("public/images/jokowi.jpg").open,
    published: true
  },
  {
    name: "Michael Jackson The King of Pop", 
    description: "<p>Who does not know Michael Jackson as a pop singer legend? We think everyone knows him. Here we will test you how much you know him.</p>\r\n", 
    image: Rails.root.join("public/images/jackson.jpg").open,
    published: true
  },
  {
    name: "All About Bali", 
    description: "<p>Bali as one of the provinces of Indonesia known as paradise for foreign tourists. We will try you how much to know Bali.</p>\r\n", 
    image: Rails.root.join("public/images/bali.jpg").open,
    published: true}
])
CategoryPlaying.create!([
  {category_id: 1, user_id: 1, category_token: "0c3daf5466", total_questions: 6, total_corrects: 6, point: "1.0"},
  {category_id: 3, user_id: 2, category_token: "2b200b803a", total_questions: 4, total_corrects: 2, point: "0.5"},
  {category_id: 2, user_id: 2, category_token: "9d796cbc2b", total_questions: 5, total_corrects: 5, point: "1.0"}
])
Question.create!([
  {category_id: 1, content: "<p>How many airports are there in Jakarta?</p>\r\n", answer: "2", image: nil, published: true, position: 3},
  {category_id: 1, content: "<p>In which island of Indonesia is Jakarta?</p>\r\n", answer: "java", image: nil, published: true, position: 1},
  {category_id: 1, content: "<p>Jakarta is divided into how many regions?</p>\r\n", answer: "5", image: nil, published: true, position: 2},
  {category_id: 1, content: "<p>What is the name of the highest monument in Jakarta?</p>\r\n", answer: "monas", image: nil, published: true, position: 4},
  {category_id: 1, content: "<p>Batavia is the previous name of Jakarta name (true or false)?</p>\r\n", answer: "true", image: nil, published: true, position: 5},
  {category_id: 2, content: "<p>Who is the real name of Michael Jackson?</p>\r\n", answer: "Michael Joseph Jackson", image: nil, published: true, position: 1},
  {category_id: 2, content: "<p>What year was he born?</p>\r\n", answer: "1958", image: nil, published: true, position: 2},
  {category_id: 2, content: "<p>What year did he die?</p>\r\n", answer: "2009", image: nil, published: true, position: 3},
  {category_id: 2, content: "<p>At what age did he die?</p>\r\n", answer: "50", image: nil, published: true, position: 4},
  {category_id: 2, content: "<p>Is the song &quot;Earth Song&quot; his creation (true or false) ?</p>\r\n", answer: "true", image: nil, published: true, position: 5},
  {category_id: 1, content: "<p>Jayakarta is the previous name of Jakarta name (true or false)?</p>\r\n", answer: "true", image: nil, published: true, position: 6},
  {category_id: 3, content: "<p>Is he the seventh President of Indonesia (true or false) ?</p>\r\n", answer: "true", image: nil, published: true, position: 1},
  {category_id: 3, content: "<p>What year was he born?</p>\r\n", answer: "1961", image: nil, published: true, position: 2},
  {category_id: 3, content: "<p>In 2018 what is the age of Jokowi?</p>\r\n", answer: "56", image: nil, published: true, position: 3},
  {category_id: 3, content: "<p>In 2012 he served as Governor of Jakarta. True or false?</p>\r\n", answer: "true", image: nil, published: true, position: 4},
  {category_id: 4, content: "<p>What is the name of the capital of Bali?</p>\r\n", answer: "denpasar", image: nil, published: true, position: 1},
  {category_id: 4, content: "<p>What is the name of the Hindu prayer place in Bali?</p>\r\n", answer: "pura", image: nil, published: true, position: 4},
  {category_id: 4, content: "<p>What religion is the most adherent in Bali?</p>\r\n", answer: "hindu", image: nil, published: true, position: 3},
  {category_id: 4, content: "<p>Kecak is one of Balinese dance art. True or false?</p>\r\n", answer: "true", image: nil, published: true, position: 2},
  {category_id: 4, content: "<p>Kuta beach is one of the most visited places by tourists when visiting Bali. True or false?</p>\r\n", answer: "true", image: nil, published: true, position: 5},
  {category_id: 4, content: "<p>Pura is a place of Hindu prayer. What is the biggest pura&nbsp;in Bali?</p>\r\n", answer: "besakih", image: nil, published: true, position: 6}
])
QuestionAnswer.create!([
  {category_id: 1, question_id: 2, answer: "java", category_token: "0c3daf5466", is_correct: true, user_id: 1},
  {category_id: 1, question_id: 1, answer: "five", category_token: "0c3daf5466", is_correct: true, user_id: 1},
  {category_id: 1, question_id: 3, answer: "two", category_token: "0c3daf5466", is_correct: true, user_id: 1},
  {category_id: 1, question_id: 4, answer: "MONAS", category_token: "0c3daf5466", is_correct: true, user_id: 1},
  {category_id: 1, question_id: 5, answer: "true", category_token: "0c3daf5466", is_correct: true, user_id: 1},
  {category_id: 1, question_id: 11, answer: "true", category_token: "0c3daf5466", is_correct: true, user_id: 1},
  {category_id: 3, question_id: 12, answer: "true", category_token: "2b200b803a", is_correct: true, user_id: 2},
  {category_id: 3, question_id: 13, answer: "one thousand nine hundred sixty-one", category_token: "2b200b803a", is_correct: false, user_id: 2},
  {category_id: 3, question_id: 14, answer: "fifty", category_token: "2b200b803a", is_correct: false, user_id: 2},
  {category_id: 3, question_id: 15, answer: "true", category_token: "2b200b803a", is_correct: true, user_id: 2},
  {category_id: 2, question_id: 6, answer: "Michael Joseph Jackson", category_token: "9d796cbc2b", is_correct: true, user_id: 2},
  {category_id: 2, question_id: 7, answer: "1958", category_token: "9d796cbc2b", is_correct: true, user_id: 2},
  {category_id: 2, question_id: 8, answer: "2009", category_token: "9d796cbc2b", is_correct: true, user_id: 2},
  {category_id: 2, question_id: 9, answer: "50", category_token: "9d796cbc2b", is_correct: true, user_id: 2},
  {category_id: 2, question_id: 10, answer: "true", category_token: "9d796cbc2b", is_correct: true, user_id: 2}
])
