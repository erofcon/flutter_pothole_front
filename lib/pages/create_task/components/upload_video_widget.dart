import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants.dart';
import 'upload_video_data.dart';

class RunDetectionPage extends StatefulWidget {
  const RunDetectionPage(
      {Key? key,
      required this.uploadCallback,
      required this.selectDateTimeCallback,
      required this.selectFileCallback})
      : super(key: key);

  final Function() uploadCallback;
  final Function() selectDateTimeCallback;
  final Function() selectFileCallback;

  @override
  State<RunDetectionPage> createState() => _RunDetectionPageState();
}

class _RunDetectionPageState extends State<RunDetectionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(
              top: defaultPadding * 3,
              left: defaultPadding,
              right: defaultPadding),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                S.of(context).run_detection,
                style: const TextStyle(fontSize: 25),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Text(S.of(context).dateTime),
              const SizedBox(
                height: defaultPadding,
              ),
              ElevatedButton(
                onPressed: widget.selectDateTimeCallback,
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.white,
                  side: const BorderSide(width: 1, color: Colors.black12),
                ),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Center(
                      child: Text(
                        Provider.of<ChangeData>(context).dateTime != null
                            ? Provider.of<ChangeData>(context)
                                .dateTime
                                .toString()
                            : S.of(context).select_date_time,
                        style: const TextStyle(color: Colors.black),
                      ),
                    )),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Text(S.of(context).attach_video),
              const SizedBox(
                height: defaultPadding,
              ),
              ElevatedButton(
                  onPressed: widget.selectFileCallback,
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: Colors.white,
                    side: const BorderSide(width: 1, color: Colors.black12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding * 2),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.upload,
                          color: Colors.black,
                          size: 48,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          Provider.of<ChangeData>(context).file != null
                              ? Provider.of<ChangeData>(context).file.name
                              : S.of(context).select_video,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: defaultPadding * 0.5,
              ),
              Text(
                S.of(context).accepted_video_types,
                style: const TextStyle(color: Colors.black45),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Provider.of<ChangeData>(context).isLoading
                  ? Center(
                      child: CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 10.0,
                        percent:
                            Provider.of<ChangeData>(context).progress / 100,
                        progressColor: Theme.of(context).primaryColor,
                        center: Icon(
                          Icons.upload,
                          size: 55,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: widget.uploadCallback,
                      style: ElevatedButton.styleFrom(
                        // elevation: 0.0,
                        primary: Theme.of(context).primaryColor,
                        // side: const BorderSide(width: 1, color: Colors.black12),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        child: Center(child: Text(S.of(context).upload)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
