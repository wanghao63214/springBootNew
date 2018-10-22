package com.realm;

import com.dao.beans.Account;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import com.common.exception.UserDisableException;
import com.service.LoginService;
import com.service.UserService;

/**
 * 自定义realm，用于用户登录的验证和授权
 * @author zhangge
 */
public class UserRealm extends AuthorizingRealm {

	@Autowired
	private UserService userService;

	@Autowired
	private LoginService loginService;
	
	/**
	 * 用户授权方法，在调用 hasRole hasRoles hasPermission hasPermissions checkRole
	 * isRole等方法时被调用
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		// TODO 暂时不加入权限到登录用户，防止验证不过，返回一个空的 AuthorizationInfo 对象
		String username = (String) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		try {
			info.setStringPermissions(userService.queryPermissionsByUserName(username));
		} catch (Exception e) {
		}
		return info;
	}

	/**
	 * 用户认证方法，在调用login方法后，调用该方法
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		Account account = null;
		UsernamePasswordToken upToken = (UsernamePasswordToken)token;
		String formUsername = upToken.getUsername();
		try {
			account = loginService.selectAcountByUserName(formUsername);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (account == null) {
			throw new UnknownAccountException();// 用户不存在
		}

		if (account.getUserstatus() == 2) {
			throw new UserDisableException("用户被禁用");
		}

		AuthenticationInfo info = new SimpleAuthenticationInfo(account.getUsername(), account.getPwd(),
				ByteSource.Util.bytes(account.getSalt()), getName());
		
		// 放到shiro的session中
		setSession("currentUser", account);
		return info;
	}

	@Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }
	
	/**
	 * 初始化shiro的加密方式
	 */
	public void initCredentialsMatcher() {
		SimpleHash sh = new SimpleHash("MD5", "000000", "100", 2);
		System.out.println(sh);
		System.out.println("初始化shiro的加密方式");
		HashedCredentialsMatcher credentialsMatcher = new HashedCredentialsMatcher();
		credentialsMatcher.setHashAlgorithmName("MD5");
		credentialsMatcher.setHashIterations(2);
		setCredentialsMatcher(credentialsMatcher);
	}

	/**
	 * 将特殊数据放入到shiro的session中，让shiro来进行管理
	 * 
	 * @param key
	 * @param value
	 */
	private void setSession(Object key, Object value) {
		Subject subject = SecurityUtils.getSubject();
		if (null != subject) {
			Session session = subject.getSession();
			if (null != session) {
				session.setAttribute(key, value);
			}
		}
	}

}
