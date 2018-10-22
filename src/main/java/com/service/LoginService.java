package com.service;


import java.util.List;
import java.util.Map;
import com.dao.beans.Account;
import com.dao.beans.AccountExample;
import com.dao.mapper.AccountMapper;
import com.dao.mapper.AuthorityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

	@Autowired
	private AuthorityMapper authorityMapper;

	@Autowired
	private AccountMapper accountMapper;
	
	/**
	 * 根据角色id 查询显示菜单
	 * @param roleId
	 * @throws Exception
	 */
	public List<Map<String, Object>> showMeun(long roleId) throws Exception{
		return authorityMapper.selectByRoleId(roleId);
	}

	public Account selectAcountByUserName(String accountName) {
		AccountExample accountExample = new AccountExample();
		AccountExample.Criteria criteria = accountExample.createCriteria();
		criteria.andUsernameEqualTo(accountName);
		List<Account> list = accountMapper.selectByExample(accountExample);
		Account account = list.get(0);
		return account;
	}

}
