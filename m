Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955302F2F
	for <iwd@lists.linux.dev>; Tue,  6 Sep 2022 19:22:11 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id io18so3558300plb.10
        for <iwd@lists.linux.dev>; Tue, 06 Sep 2022 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=55Uy089uujOab9gIzxn4eA7uzriTXVpBNrH8cl4Xt+c=;
        b=KbSlCitWEz3wqsdpmnmGZfc8T7feDf/jVDvUUP264Tsp2JgDA1T6/rY467RGOsVpNa
         jZe72BtgKzdH0jVDTZWGkmFUe5iofKFPZZmbCVBnSSuqab0AxGJ6tM5ey2tPiGChwHVW
         0ShteCPHWbQjeGtKhfppITuCdhNvUkOFqjqkMNbjr5egyfQQfSCeJ3XwVVaCjDyFp1Jr
         GIBKATtNdjndiXelbTQyoX69RMdNllWEe6NaWdj0mW8Hkyi3hOZCl83bQdxDqq1Owi0D
         S30ogpFjztigf10MU3RX47uqwxwtI6J5qPuaHeqpsna3XqgptVYgR23QazONYUntRvT5
         7PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=55Uy089uujOab9gIzxn4eA7uzriTXVpBNrH8cl4Xt+c=;
        b=r5wr05eF4cBihiu5hLrgkQr3XG6TtkdgClf15HGnwZomwrVU9TqHGi11/ILMa1dwvQ
         KBkj+ZnPKVW9mEwAqkkwSP8sg4x9cr9LF5fePVlppljVczsimjv+LnKWdfTrf0QC8U2f
         e5gWLW9kX5Os8Ye/SIvjKWnRLtBT7eqtNKFMtfMoLNox8YF8JUyhIN3QcJMzonpzTdNO
         3Sbf/bz9rbXzYt46hgUEvatsNvrj77ffch5U1+A+99tp75+TTxGijK+76u1SW9sx4axA
         CLe/S84oaraUDAAyTWwftPDNHYgPXtLXEeH5Ip0BcRIq9WP7TbS4dMwW9k72049kcEvT
         SC2Q==
X-Gm-Message-State: ACgBeo3WNxAQ0AI2TBfjUuy7C0QYFTohdxH0lCTOh8XaMEW8IolzrwWB
	jUT+M7pA8Wq0jkMdy9l2AjLh1QQOAgU=
X-Google-Smtp-Source: AA6agR6ov9RiaP3BwMvWrpTceS44DnBDPjQYA/rTvk0og7pOimxvV5gRYZ7OR44nNOWvavV0ey9J7g==
X-Received: by 2002:a17:902:ce12:b0:172:dc6e:18f6 with SMTP id k18-20020a170902ce1200b00172dc6e18f6mr55736732plg.34.1662492130894;
        Tue, 06 Sep 2022 12:22:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b00172f6726d8esm10206654pln.277.2022.09.06.12.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:22:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] netdev: remove 'req' from netdev_mac_change_failed
Date: Tue,  6 Sep 2022 12:22:07 -0700
Message-Id: <20220906192207.84986-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220906192207.84986-1-prestwoj@gmail.com>
References: <20220906192207.84986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The request object was never being used
---
 src/netdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 3cd3e4ef..7a14f1dd 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3584,8 +3584,7 @@ failed:
 	return -EIO;
 }
 
-static void netdev_mac_change_failed(struct netdev *netdev,
-					struct rtnl_data *req, int error)
+static void netdev_mac_change_failed(struct netdev *netdev, int error)
 {
 	l_error("Error setting mac address on %d: %s", netdev->index,
 			strerror(-error));
@@ -3639,7 +3638,7 @@ static void netdev_mac_power_up_cb(int error, uint16_t type,
 	if (error) {
 		l_error("Error changing per-network MAC on interface %u: %s",
 			netdev->index, strerror(-error));
-		netdev_mac_change_failed(netdev, req, error);
+		netdev_mac_change_failed(netdev, error);
 		return;
 	}
 
@@ -3665,7 +3664,7 @@ static void netdev_mac_power_down_cb(int error, uint16_t type,
 	if (error) {
 		l_error("Error taking interface %u down for per-network MAC "
 			"generation: %s", netdev->index, strerror(-error));
-		netdev_mac_change_failed(netdev, req, error);
+		netdev_mac_change_failed(netdev, error);
 		return;
 	}
 
@@ -3674,7 +3673,7 @@ static void netdev_mac_power_down_cb(int error, uint16_t type,
 					netdev_mac_power_up_cb, req,
 					netdev_mac_destroy);
 	if (!netdev->mac_change_cmd_id) {
-		netdev_mac_change_failed(netdev, req, -EIO);
+		netdev_mac_change_failed(netdev, -EIO);
 		return;
 	}
 
-- 
2.34.3

