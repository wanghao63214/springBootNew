package com.service;

import com.dao.beans.Account;
import com.dao.beans.AccountExample;
import com.dao.mapper.AccountMapper;
import com.dao.mapper.AccountMapper_Manual;
import com.dao.mapper.AuthorityMapper;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class UserService {

	@Autowired
	private AuthorityMapper authorityMapper;
	
	@Autowired
	private AccountMapper accountMapper;

    @Autowired
    private AccountMapper_Manual accountMapper_Manual;

    /**
     * Wh
     * 查询用户按钮级别的权限
     */
	public Set<String> queryPermissionsByUserName(String userName) throws Exception{
        List<String> list = null;
        Set<String> set = null;
        try {
            list = authorityMapper.selectButtonsByRoleId(1);
            set = new HashSet(list);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return set;
	}
    /**
     * wh
     *
     * @return 角色查询
     */
    public Map<String, Object> userQuery(Account user, int limit, int offset) {
        Map<String, Object> map = new HashMap<>();
        try {
            AccountExample accountExample = new AccountExample();
            map.put("total", accountMapper.countByExample(accountExample));
            PageHelper.startPage((offset / limit) + 1, limit);//startPage, PageSize
            List<Map<String, Object>> rows = accountMapper_Manual.selectListMap(accountExample);
            map.put("rows", rows);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("total", 0);
            map.put("rows", new ArrayList<>());
        }
        return map;
    }

    /**
     * 保存新用户
     * @param account
     */
    public void insert(Account account){
        try{
            account.setUserstatus(1);//1为可用
            accountMapper.insert(account);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    /**
     * 更新新用户
     */
    public void update(Account account){
        try{
            accountMapper.updateByPrimaryKeySelective(account);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    /**
     * 查询单个用户信息
     */
    public Account selectByPrimaryKey(Account account){
        return accountMapper.selectByPrimaryKey(account.getId());
    }
}
