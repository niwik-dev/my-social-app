import 'package:my_social/api/restful/note_api.dart';
import 'package:my_social/model/common/page_response.dart';
import 'package:my_social/utils/request_utils.dart';

void main(){
  AuthRequestUtils.setMockToken(
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImRlcHRJZCI6MSwiZGF0YVNjb3BlIjoxLCJleHAiOjE3NTQxMjQ4ODIsInVzZXJJZCI6MiwiaWF0IjoxNzU0MTE3NjgyLCJhdXRob3JpdGllcyI6WyJST0xFX0FETUlOIl0sImp0aSI6ImZhNjQ2NmNlYWJkNjRjNjFiNTk0ODA3ZmQwZmUzNjY2In0.f3D_9CoCHScyRNO7hqUCwAhP4J11molLg7EeLA71AU8'
  );
}