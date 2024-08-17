import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/snackbar_message.dart';
import 'package:hr_career_platform/injection_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/widgets/loading_widget.dart';
import 'features/job/domain/entities/job.dart';
import 'features/job/presentation/bloc/job_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<JobCubit>(),
      ),

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'hi'),
        );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('hi'),
      ),
      body:BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if(state is JobLoadingState){
            return const LoadingWidget();
          } else if (state is JobFetchedState){
            return  ListView.separated(
                itemBuilder: (context, index) {
                  final Job job = state.jobs[index];
                  return ListTile(
                    leading: Text(job.id.toString()),
                    title: Text(
                      job.jobTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(job.deadlineDate.toString()),);
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                ),
                itemCount:  state.jobs.length ?? 0);
          }else if(state is JobErrorState) {
            return Text(state.msg);
          }else{
            return const Text('error');
          }

        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  final String title;


}
 
