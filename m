Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0810340C04
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647475; cv=none; b=VrJYzraNqPlF0rHVD02JNwMi/62x0y+/+B5ZjlIRszh6zYGNnJENNQ/5A+OWryTdnNl/Y40kh7t5DDKOAtDduHcqBlCZx27Nr260s18EKITDaARLxNIEj+MjIC3YAPBZM59EWGVwWIW7dyBcq+JLutR4yvn/SbIoWM7xNyo75Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647475; c=relaxed/simple;
	bh=X99zTclj3L2Eh2YsA2eFNokkWt8kgKQ/i+cionD3b4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5m/ZepbzooVhmlA2W3XB0Ag10ZnRQAT8NxKyK0ghb/S2O9I+3L/eUr9iKnhZ6DJ5IJVaOx5viJz/qLEhg+TJhA43X3bmRK/GJwh7gvg3rhY0fiUCUJ+3e3CfvOkw32fx1F4dZGYU7pQPiVOcitFzTLG4Eb6FMAGAwY+i0Scgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7Nr0gtf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Nr0gtf"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69107859bedso6428486d6.2
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711647470; x=1712252270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ou6IOtjjcGYZMKrK4cR1qGTIkU8uQc38glCA8iwLAw=;
        b=V7Nr0gtfkyktvs5NvdBlb5iuUD1bDvnNMEn21znVPBXGokHjeHla/QVlG95TlCNRY3
         PAWoiC7WWEZjQ37oNrqf+YzWnheOMiBM+p3RBLUl34cB2ikMhESKuWxSD+lTYbTtJ5TO
         dw7dtCuOUE/MFqfbjXZrRyW2wmCcQIPf08FtNxqhm4EOVFnExn9s7jhJeYTe2AroAkcK
         P3jgekW2jAPTG+dmgiiUEWUWCRJSaWrrMn38AvzCsNQj6G5hDaYyAaOwwhXfMCJdnMah
         G8az2HECHg0dLbB6iQb3q6bF1tn+F5nMlKMppkuwgXxiFay9Q2P3TQJ1S5pfMBfKLrg+
         Ngzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647470; x=1712252270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ou6IOtjjcGYZMKrK4cR1qGTIkU8uQc38glCA8iwLAw=;
        b=eDudpPj5VEOG8r59pOHz5sUHSbJlkZ8NC0pbzxjH3SKokXSQH1tLwWC3UpN4AMIhLd
         C2mvvNcTinfBBAHzDrbaCTREPSwk+hiZpDZHHZaYSAK4JYqSgX37pAB8jUPwyLUQOXjT
         cbTofq4nlpX0uWBI1tSd9v6OJh9y/bv1CYYmJIVIh2ZY6b/RXVJrl/OuWzSRowCg6eH1
         zVT+9xV1e45+RR1LMk43/IszSNJru4YOjF2p9/yrnHeudw/oVm4o+0WQ+Ypj27sgcOvd
         KZRfuNwfAf7Ei1hZP9yJ5gB4Or5bjr4sPIqBG9kDg7nicMk/fjSixnMCZdF9bkWsfu2E
         02XA==
X-Gm-Message-State: AOJu0YxUarFNe/TdmxCSrcUnauN9fGKXr1EjEBcna9xHDy8aAQEa99I8
	5Oc2iDIZtTbqcsBK/Y90SBD+zZL1+iNNTGEzJRuqg64EgEHifxr9dh+59WV9
X-Google-Smtp-Source: AGHT+IELKoMl1Mxbs+fibJkqNAk0yC/nc49R1qNZZbUzZb5OgxdiOuCYb/y+b4LpSP8OkRRIh52Sjg==
X-Received: by 2002:a0c:f0d0:0:b0:696:8a6f:afde with SMTP id d16-20020a0cf0d0000000b006968a6fafdemr3569778qvl.24.1711647470551;
        Thu, 28 Mar 2024 10:37:50 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id kk15-20020a056214508f00b00696a78b9cc6sm827751qvb.53.2024.03.28.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:37:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: use CMD_DEAUTHENTICATE when needed on disconnect
Date: Thu, 28 Mar 2024 10:37:45 -0700
Message-Id: <20240328173745.1574384-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_disconnect() was unconditionally sending CMD_DISCONNECT which
is not the right behavior when IWD has not associated. This means
that if a connection was started then immediately canceled with
the Disconnect() method the kernel would continue to authenticate.

Instead if IWD has not yet associated it should send a deauth
command which causes the kernel to correctly cleanup its state and
stop trying to authenticate.

Below are logs showing the behavior. Autoconnect is started followed
immediately by a DBus Disconnect call, yet the kernel continues
sending authenticate events.

event: state, old: autoconnect_quick, new: connecting (auto)
src/scan.c:scan_cancel() Trying to cancel scan id 1 for wdev 7d
src/wiphy.c:wiphy_radio_work_done() Work item 1 done
src/wiphy.c:wiphy_radio_work_next() Starting work item 2
src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
src/station.c:station_dbus_disconnect()
src/station.c:station_reset_connection_state() 85
src/station.c:station_roam_state_clear() 85
event: state, old: connecting (auto), new: disconnecting
src/wiphy.c:wiphy_radio_work_done() Work item 2 done
src/station.c:station_connect_cb() 85, result: 5
src/station.c:station_disconnect_cb() 85, success: 1
event: state, old: disconnecting, new: disconnected
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
Unexpected connection related event -- is another supplicant running?
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
Unexpected connection related event -- is another supplicant running?
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
Unexpected connection related event -- is another supplicant running?
src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
src/netdev.c:netdev_authenticate_event()
Unexpected connection related event -- is another supplicant running?
---
 src/netdev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 09fac959..26e36081 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3935,6 +3935,8 @@ int netdev_disconnect(struct netdev *netdev,
 {
 	struct l_genl_msg *disconnect;
 	bool send_disconnect = true;
+	bool deauth = false;
+	uint8_t aa[6];
 
 	if (!(netdev->ifi_flags & IFF_UP))
 		return -ENETDOWN;
@@ -3953,8 +3955,8 @@ int netdev_disconnect(struct netdev *netdev,
 		 * 1. We do not actually have a connect in progress (work.id
 		 *    is zero), then we can bail out early with an error.
 		 * 2. We have sent CMD_CONNECT but not fully connected. The
-		 *    CMD_CONNECT needs to be canceled and a disconnect should
-		 *    be sent.
+		 *    CMD_CONNECT needs to be canceled and a disconnect or
+		 *    deauth should be sent.
 		 * 3. Queued up the connect work, but haven't sent CMD_CONNECT
 		 *    to the kernel. This case we do not need to send a
 		 *    disconnect.
@@ -3969,6 +3971,11 @@ int netdev_disconnect(struct netdev *netdev,
 							netdev->work.id))
 			send_disconnect = false;
 
+		if (netdev->handshake && !netdev->associated) {
+			memcpy(aa, netdev->handshake->aa, 6);
+			deauth = true;
+		}
+
 		netdev_connect_failed(netdev, NETDEV_RESULT_ABORTED,
 					MMPDU_REASON_CODE_UNSPECIFIED);
 	} else {
@@ -3976,8 +3983,14 @@ int netdev_disconnect(struct netdev *netdev,
 	}
 
 	if (send_disconnect) {
-		disconnect = nl80211_build_disconnect(netdev->index,
+		if (deauth)
+			disconnect = nl80211_build_deauthenticate(
+					netdev->index, aa,
 					MMPDU_REASON_CODE_DEAUTH_LEAVING);
+		else
+			disconnect = nl80211_build_disconnect(netdev->index,
+					MMPDU_REASON_CODE_DEAUTH_LEAVING);
+
 		netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
 					disconnect, netdev_cmd_disconnect_cb,
 					netdev, NULL);
-- 
2.34.1

