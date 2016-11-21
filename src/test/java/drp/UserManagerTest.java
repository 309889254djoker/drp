package drp;

import java.util.List;

import com.bjpowernode.drp.sysmgr.manager.UserManager;
import com.bjpowernode.drp.util.PageModel;

public class UserManagerTest {

	public static void main(String[] args){
		int pageNo = 1;
		int pageSize = 2;
		PageModel pageModel = UserManager.getInstance().findUserList(pageNo, pageSize);
	}
}
