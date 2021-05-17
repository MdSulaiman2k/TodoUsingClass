require "date"

class Todo
  #contructor
  def initialize(text, dueDate, completed)
    @text = text
    @due_date = dueDate
    @is_completed = completed
  end

  # returns booleaan value overdue or not
  def overdue?
    @due_date < Date.today
  end

  # returns booleaan value duetoday or not
  def due_today?
    @due_date == Date.today
  end

  # returns booleaan value duelater or not
  def due_later?
    @due_date > Date.today
  end

  # retuns the string what pattern user wants
  def to_displayable_string
    display_status = @is_completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : @due_date
    "#{display_status} #{@text} #{display_date}"
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  #it will push the todo in the todolist
  def add(todo)
    @todos.push(todo)
  end

  # it will return the todolist of overdue
  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  # it will return the todolist of duetoday
  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  # it will return the todolist of duelater
  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  # display the todolist
  def to_displayable_list
    displaytodo = @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
