
import 'package:timeago/timeago.dart' as timeago;
String timeAgo (DateTime date){
  return timeago.format(date , allowFromNow : true , locale : 'en');
}