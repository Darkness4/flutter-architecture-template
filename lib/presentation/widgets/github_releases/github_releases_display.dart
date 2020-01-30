import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';

class GithubReleasesDisplay extends StatelessWidget {
  final List<GithubRelease> releases;

  const GithubReleasesDisplay({
    Key key,
    this.releases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: releases.length,
        itemBuilder: (BuildContext context, int index) => Card(
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 100,
                height: 200,
                child: Placeholder(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      SelectableText(
                        releases[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SelectableText(
                        releases[index].body,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
