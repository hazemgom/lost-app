import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_stone/feature/payment-feature/cridt-card-screen.dart';
import 'package:save_stone/helper/components/custom_components.dart';
import 'package:save_stone/helper/cubit/home_cubit.dart';
import 'package:save_stone/model/post_model.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return buildPostItem(context, HomeCubit.get(context).posts[index],
                index, HomeCubit.get(context));
          },
          itemCount: HomeCubit.get(context).posts.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
        );
      },
    );
  }

  Widget buildPostItem(context, PostModel model, index, HomeCubit cubit) {
    var location = TextEditingController();
    location.text = model.location;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        CridtCardScreen(
                          postModel: cubit.posts[index],
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          CachedNetworkImageProvider(cubit.posts[index].image),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.name.toString(),
                          style: const TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                    Text(
                      model.dateTime.toString().substring(0, 10),
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const Spacer(),
                if (cubit.userModel.uId == cubit.posts[index].uId)
                  IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration:
                                        const BoxDecoration(color: Colors.white),
                                    child: MaterialButton(
                                      onPressed: () {
                                        cubit.DeletePost(cubit.postId[index]);
                                      },
                                      child: const Text('Delete Post'),
                                    ),
                                  ),
                                ),

                              ],
                            )));
                      },
                      icon: const Icon(Icons.more_horiz)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text.toString(),
              maxLines: 6,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 12,
            ),
            if (model.postImage != '')
              Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            model.postImage.toString()),
                        fit: BoxFit.contain)),
              ),
            const SizedBox(
              height: 12,
            ),
            TextButton(
              onPressed: () {},
              child: model.location.isEmpty
                  ? Text(
                      model.location,
                      textAlign: TextAlign.center,
                      maxLines: 6,
                      style: const TextStyle(color: Colors.blue),
                    )
                  : TextField(
                      enabled: false,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: location.text,
                          hintStyle: const TextStyle(color: Colors.blue)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
