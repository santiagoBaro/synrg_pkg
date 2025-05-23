// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:synrg/synrg.dart';

/// Creates Paginated list of items from a query with pagination
class QueryList extends StatefulWidget {
  ///
  const QueryList({
    required this.query,
    required this.itemBuilder,
    this.loadingState,
    this.pageSize = 10,
    this.scrollDirection = Axis.vertical,
    this.startPadding = 0,
    this.emptyState,
    super.key,
  });

  final Future<List<dynamic>?> Function({String? startAfter, int limit}) query;
  final Widget? Function(BuildContext context, dynamic item) itemBuilder;
  final Axis scrollDirection;
  final Widget? loadingState;
  final Widget? emptyState;
  final int pageSize;
  final double startPadding;

  @override
  State<QueryList> createState() => _QueryListState();
}

class _QueryListState extends State<QueryList> {
  List<dynamic> items = [];
  RequestStatus status = RequestStatus.pending;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      status = RequestStatus.loading;
    });
    final newItems = await widget.query(limit: widget.pageSize);
    if (newItems != null) {
      setState(() {
        items = newItems;
        status = RequestStatus.success;
      });
    } else {
      setState(() {
        status = RequestStatus.error;
      });
    }
  }

  Future<void> _addItems(String startAfter) async {
    setState(() {
      status = RequestStatus.loading;
    });

    final newItems = await widget.query(
      startAfter: startAfter,
      limit: widget.pageSize,
    );

    if (newItems != null) {
      setState(() {
        // ignore: avoid_dynamic_calls
        final existingItemIds = items.map((item) => item.id).toSet();

        final filteredNewItems = newItems
            // ignore: avoid_dynamic_calls
            .where((item) => !existingItemIds.contains(item.id))
            .toList();

        items = items + filteredNewItems;

        status = RequestStatus.success;
      });
    } else {
      setState(() {
        status = RequestStatus.error;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _loadItems();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (items.isNotEmpty && notification.metrics.extentAfter < 400) {
            // ignore: avoid_dynamic_calls
            _addItems(items.last.id as String);
          }
          return false;
        },
        child: (items.isEmpty)
            ? (status == RequestStatus.loading)
                ? widget.loadingState ??
                    const Center(child: CircularProgressIndicator())
                : widget.emptyState ??
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.emoji_people,
                                size: 288,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 24),
                              Text(
                                'No items found',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Stesp to add items',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    if (widget.scrollDirection == Axis.horizontal) {
                      return SizedBox(width: widget.startPadding);
                    } else {
                      return SizedBox(height: widget.startPadding);
                    }
                  }
                  return widget.itemBuilder(context, items[index - 1]);
                },
                scrollDirection: widget.scrollDirection,
              ),
      ),
    );
  }
}
