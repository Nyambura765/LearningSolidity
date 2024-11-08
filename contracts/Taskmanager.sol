//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


contract TaskMananger {
    // enum
    enum Status {
        ToDo,
        InProgress,
        Done
    }

    // struct
    struct Task {
        string description;
        bool completed;
        Status status;
    }

    Task[] public tasks; //array
    //mapping
    mapping(address => uint[]) public userTasks;

    //  Function to add a new task
    function addTask(string memory _description) public {
        tasks.push(Task(_description, false, Status.ToDo));
        uint taskId = tasks.length - 1;
        userTasks[msg.sender].push(taskId);
    }

    //  Function to update a task's status
    function updateTaskStatus(uint _taskId, Status _status) public {
        require(_taskId < tasks.length, "Task does not exist"); // checks if a task Id exists
        tasks[_taskId].status = _status;
    }

    // Function to  mark a task as completed
    function completeTask(uint _taskId) public {
        require(_taskId < tasks.length, "Task does not exist");//checks if a task Id exists
        tasks[_taskId].completed = true;
        tasks[_taskId].status = Status.Done;
    }
}
