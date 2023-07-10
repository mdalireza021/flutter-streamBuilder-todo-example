import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'controllers/todoController.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingController = TextEditingController();
  //final TextEditingController _searchEditingController = TextEditingController();

  final TodoController _todoController = TodoController();
   late List<Todo> filteredTodo;
   int count =0;

   @override
  void initState() {

     _todoController.todoStream.listen((event) {
       setState(() {
         count= event.length;
       });
     });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(count),
      backgroundColor: tdBGColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 20),
                  child: const Text(
                    "All todos",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
                StreamBuilder<List<Todo>>(
                  stream: _todoController
                      .todoStream, // Replace `yourStream` with the actual stream you want to listen to
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      // Stream has emitted data
                      var data = snapshot.data;
                      // Build your UI based on the data
                      return Column(
                        children: data!
                            .map((e) => TodoItem( todoController: _todoController,onUpdateTodo: _onUpdateTodo, onDeleteTodo: _onDeleteTodo,
                                  todo: e,
                                ))
                            .toList(),
                      );
                    } else if (snapshot.hasError) {
                      // Stream has encountered an error
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Stream is still loading
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.all(20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                        hintText: "Add a new todo item",
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      _todoController.addTodo(Todo(
                          id: _todoController.listItemCount()+1,
                          todoText: _textEditingController.text,
                          isCompleted: false));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {

     _todoController.filteredTodo(enteredKeyword);
  }

  void _onUpdateTodo(Todo todo) {
    _todoController.updateTodo(todo);
  }

  void _onDeleteTodo(int id)
  {
    _todoController.deleteTodo(id);
  }

  AppBar _buildAppBar(int count) {
    return AppBar(
      backgroundColor: tdBlack,
      title:  Text(count.toString()),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child:  TextField(
       onChanged: (value)=> {
         print(value),
         _todoController.filteredTodo(value) },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxWidth: 25,
            maxHeight: 20,
          ),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}
