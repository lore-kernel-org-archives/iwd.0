Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603E4C63
	for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 14:48:18 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id c11so7200570wrp.11
        for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 07:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qU43tN+gys00gx+PfR1AXIYO2f5fHS6srRN84ZsCt3Q=;
        b=CSWhFySNdyjUAV3Gawd/MXCsSJWzFIAWsVC0xJO3aWMN7SzpKoR/M8CmOOm27vpZ41
         Z8f8nNpFFzLWzg9zc8QeHphOvD197aevqyXKBlM9wAKREh3+ayx5PBo6pq8F0UZgKJ5V
         G/Wo8yj/hSSkV/j1VJuFtHKeHKLyrXgP8/qINqOGs6Sf89cfQRApTQrl7XcZ0PB3MEaD
         7ZROQHEnangVe1PAqPH+vncPi1RKc1FsGpARLW6xz7wqYnxajLx3Xv7xf7NbMm0DXGUc
         wtO7RTDORTTsFyMruxQDw7orNK0Lq0xlCUFCfWHpu87heMv+inyDaOLifF9w87yUlejM
         v3Ag==
X-Gm-Message-State: ACrzQf3JiNEifxv1pTgrpA7itqnp3XaL0fNmitCUHeXETaCDSVK8cObz
	OyaVHffz/qOFFulVh9BilVirTF2lrNc=
X-Google-Smtp-Source: AMsMyM41TSjYbuJQYm20irRkkvNWrDa9MSHuPN9A3Ml8z3m5oN2OJNwGRGEsML7zK6FcrGH7KMWrqg==
X-Received: by 2002:adf:d215:0:b0:228:6293:10ff with SMTP id j21-20020adfd215000000b00228629310ffmr6069275wrh.171.1664549296540;
        Fri, 30 Sep 2022 07:48:16 -0700 (PDT)
Received: from localhost.localdomain ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003b505d26776sm6900284wml.5.2022.09.30.07.48.15
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:48:16 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 2/3] station: Handle NETCONFIG_EVENT_FAILED
Date: Fri, 30 Sep 2022 16:48:00 +0200
Message-Id: <20220930144801.548229-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930144801.548229-1-andrew.zaborowski@intel.com>
References: <20220930144801.548229-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If IPv4 setup fails and the netconfig logic gives up, continue as if the
connection had failed at earlier stages so that autoconnect can try the
next available network.
---
 src/station.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/station.c b/src/station.c
index 6bd66ffc..fdeab7c1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2101,6 +2101,30 @@ delayed_retry:
 	station_roam_retry(station);
 }
 
+static void station_disconnect_on_error_cb(struct netdev *netdev, bool success,
+					void *user_data)
+{
+	struct station *station = user_data;
+	bool continue_autoconnect;
+
+	station_enter_state(station, STATION_STATE_DISCONNECTED);
+
+	continue_autoconnect = station->state == STATION_STATE_CONNECTING_AUTO;
+
+	if (continue_autoconnect) {
+		if (station_autoconnect_next(station) < 0) {
+			l_debug("Nothing left on autoconnect list");
+			station_enter_state(station,
+					STATION_STATE_AUTOCONNECT_FULL);
+		}
+
+		return;
+	}
+
+	if (station->autoconnect)
+		station_enter_state(station, STATION_STATE_AUTOCONNECT_QUICK);
+}
+
 static void station_netconfig_event_handler(enum netconfig_event event,
 							void *user_data)
 {
@@ -2109,7 +2133,26 @@ static void station_netconfig_event_handler(enum netconfig_event event,
 	switch (event) {
 	case NETCONFIG_EVENT_CONNECTED:
 		station_enter_state(station, STATION_STATE_CONNECTED);
+		break;
+	case NETCONFIG_EVENT_FAILED:
+		if (station->connect_pending) {
+			struct l_dbus_message *reply = dbus_error_failed(
+						station->connect_pending);
+
+			dbus_pending_reply(&station->connect_pending, reply);
+		}
+
+		if (L_IN_SET(station->state, STATION_STATE_CONNECTING,
+				STATION_STATE_CONNECTING_AUTO))
+			network_connect_failed(station->connected_network,
+						false);
+
+		netdev_disconnect(station->netdev,
+					station_disconnect_on_error_cb,
+					station);
+		station_reset_connection_state(station);
 
+		station_enter_state(station, STATION_STATE_DISCONNECTING);
 		break;
 	default:
 		l_error("station: Unsupported netconfig event: %d.", event);
-- 
2.34.1

