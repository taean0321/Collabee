package WebSocket;


import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.StringTokenizer;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.ta.dao.LinkDao;

@ServerEndpoint("/broadcasting")
public class BroadSocket {
	public static Set<Session> setClients = Collections.synchronizedSet(new HashSet<Session>());
		
	@OnMessage		// 클라이언트로부터 메시지가 도착했을 때.
	public void onMessage(String message, Session session) {
		try {
			if(message.contains("www")) {
				LinkDao lDao = new LinkDao();
				StringTokenizer st = new StringTokenizer(message, ".", true);
				int cnt =0;
				while(st.hasMoreTokens()) {
					if(st.nextToken().equals(".")) {
						cnt++;
					}
				}
				if(cnt==2) {
					if(message.contains("https://") || message.contains("http://")) {
						if(lDao.linkTitle(message).equals("")) {
							synchronized(setClients) {
								for(Session client : setClients) {
									if(!client.equals(session)) {
										client.getBasicRemote().sendText(message);
									}
								}
							}
						} else {
							for(Session client : setClients) {
								if(!client.equals(session)) {
									client.getBasicRemote().sendText(message);
								}
							}
						}
					} else {
						String plusMessage = "https://" + message;
						if(lDao.linkTitle(message).equals("")) {
							synchronized(setClients) {
								for(Session client : setClients) {
									if(!client.equals(session)) {
										client.getBasicRemote().sendText(message);
									}
								}
							}
						} else {
							for(Session client : setClients) {
								if(!client.equals(session)) {
									client.getBasicRemote().sendText(message);
								}
							}
						}
					}
				}
					
			} else {
				synchronized(setClients) {
					for(Session client : setClients) {
						if(!client.equals(session)) {
							client.getBasicRemote().sendText(message);
						}
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}	

	@OnOpen			// 클라이언트가 서버로 접속했을 때.
	public void onOpen(Session session) {
		setClients.add(session);
	}
	
	@OnClose		// 클라이언트의 접속이 끊어졌을 때.
	public void onClose(Session session) {
		setClients.remove(session);
	}
}




