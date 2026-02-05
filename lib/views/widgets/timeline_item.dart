import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final bool active;
  final String? update;
  final String? updateDate;
  final String? author;
  final String? description;
  final bool hideDivider;
  const TimelineItem({super.key, this.active = false, this.update, this.updateDate, this.author, this.description, this.hideDivider =false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            spacing: 5,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: active ? Color(0xFFdbeafe) : Color(0xFFf1f5f9),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: active ? Color(0xFF2b7fff) : Color(0xFF90a1b9),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              if(!hideDivider)
                Expanded(
                  child: Container(
                    width: 1,
                    color: Color(0xFFe2e8f0),
                  ),
                ),
            ],
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              children: [
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(update!=null)
                          Text(update!,style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurface,
                              fontVariations: [
                                FontVariation('wght', 600)
                              ]
                          ),),
                        if(author!=null)
                          Text("by $author",style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                              fontVariations: [
                                FontVariation('wght', 400)
                              ]
                          ),),
                      ],
                    ),
                    if(updateDate!=null)
                      Text(updateDate!,style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                          fontVariations: [
                            FontVariation('wght', 400)
                          ]
                      ),)
                  ],
                ),
                SizedBox(height: 10,),
                if(description!=null)
                  Expanded(child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFf8fafc),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(description!,style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant
                    ),),
                  ))
              ],
            ),
          ),
        ],
      ),
    );

  }
}
