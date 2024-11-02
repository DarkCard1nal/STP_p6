# STP_p6

_Created for the course "Stack of programming technologies" V. N. Karazin Kharkiv National University_

Ruby 3.3.5 "Tasklist" program.

---

The main executable file `program.rb`.

Tasklist is a program with a command line interface that stores a list of tasks, can add, modify, delete, sort, and display tasks.

Each task has a `name`, a `deadline`, and a `status` (`true` - completed, `false` - not completed).

The list of tasks is saved when the program exits and restored when it is restarted,
the default file is `task_list_db.json`, it can be changed by passing a new name as an argument at startup,
for example `ruby program.rb "my_file_tasks.json"`,
if this file is not available, the program will try to save the data to the backup file `task_list_db_backup.json`.

The data is stored in JSON format.

# Examples

```ruby
> ruby program.rb
"Tasklist" by Shkilnyi V. CS31
0 - Exit
1 - Display tasks
2 - Add task
3 - Change task by idex
4 - Change the status of a task by index
5 - Delete a task by idex
6 - Sort tasks
7 - Clear tasks
8 - Display completed tasks
9 - Display uncompleted tasks
10 - Display tasks by filter name
11 - Display tasks by filter deadline
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
Choose an action:
>
Command not found!
"Tasklist" by Shkilnyi V. CS31
0 - Exit
1 - Display tasks
2 - Add task
3 - Change task by idex
4 - Change the status of a task by index
5 - Delete a task by idex
6 - Sort tasks
7 - Clear tasks
8 - Display completed tasks
9 - Display uncompleted tasks
10 - Display tasks by filter name
11 - Display tasks by filter deadline
Choose an action:
> 2
Add task
Enter the name of the task:
> task1
Enter the deadline of the task:
> 2025.01.01
Task Added
Choose an action:
> 2
Add task
Enter the name of the task:
> task2
Enter the deadline of the task:
> 2025.01.02
Task Added
Choose an action:
> 2
Add task
Enter the name of the task:
> task3
Enter the deadline of the task:
> 2025.01.01
Task Added
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task2, false, 2025.01.02
3, task3, false, 2025.01.01
Choose an action:
> 3
Change task by idex
Enter the index of the task:
> 0
Task with this index was not found
Choose an action:
> 3
Change task by idex
Enter the index of the task:
> 2
Task: {name: task2; deadline: 2025.01.02; status: false}
Enter the new name of the task:
> task4
Enter the new deadline of the task:
> 2025.01.03
Task Changed
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task4, false, 2025.01.03
3, task3, false, 2025.01.01
Choose an action:
> 6
Sort tasks
tasks Sorted
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task3, false, 2025.01.01
3, task4, false, 2025.01.03
Choose an action:
> 4
Change the status of a task by index
Enter the index of the task:
> 2
Task Changed
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task3, true, 2025.01.01
3, task4, false, 2025.01.03
Choose an action:
> 6
Sort tasks
tasks Sorted
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task4, false, 2025.01.03
3, task3, true, 2025.01.01
Choose an action:
> 8
Display completed tasks
№, Name, Status, Dedline
1, task3, true, 2025.01.01
Choose an action:
> 9
Display uncompleted tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task4, false, 2025.01.03
Choose an action:
> 10
Display tasks by filter name
Enter the name of the task:
> task1
№, Name, Status, Dedline
1, task1, false, 2025.01.01
Choose an action:
> 11
Display tasks by filter deadline
Enter the deadline of the task:
> 2025.01.01
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task3, true, 2025.01.01
Choose an action:
> 10
Display tasks by filter name
Enter the name of the task:
> task0
№, Name, Status, Dedline
Choose an action:
> 3
Change task by idex
Enter the index of the task:
> 2
Task: {name: task4; deadline: 2025.01.03; status: false}
Enter the new name of the task:
> task2
Enter the new deadline of the task:
> 2025.01.03
Task Changed
Choose an action:
> 2
Add task
Enter the name of the task:
> task12
Enter the deadline of the task:
> 2025.01.04
Task Added
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task2, false, 2025.01.03
3, task3, true, 2025.01.01
4, task12, false, 2025.01.04
Choose an action:
> 5
Delete a task by idex
Enter the index of the task:
> 4
Task: {name: task12; deadline: 2025.01.04; status: false}
Task Deleted
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
1, task1, false, 2025.01.01
2, task2, false, 2025.01.03
3, task3, true, 2025.01.01
Choose an action:
> 7
Clear tasks
tasks is empty
Choose an action:
> 1
Display tasks
№, Name, Status, Dedline
Choose an action:
> 0
Exit
Data saved, program execution completed
```
