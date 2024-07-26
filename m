Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5C2C684
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033479; cv=none; b=ScMzzb7NqNLYjBhn658i+jxbpw++ODlipX9kqaaaCnYzdDqblkcROmgWkSNoDU+fAxKSDhoKucs19oKfqwaZKiQiMbd9P92d602im15KouiqN9tYVd7H8yTVGl7qSd5W/vb68DQ86aS+9t3F68DmUSRKoXPF+Yq4cKb3cFDoY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033479; c=relaxed/simple;
	bh=RGxWIpELRzPmeNWgjbtIsOZIGWA2AMv2AbW5bAzbjWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THJcpPDoPwgKNK7ynTKzjXfvTCRSB8fs5C/BDr+Uc25GUGl3TK393TkH2/o7lCm1bxBhurn2OOYEfwqquejPNBsZ6cW0DxvBYO8spA44Ki/NPAsnx+WwzK2c1zQWugJDsCGBOGumQNOcB+aHFpztJ/AW3rrhVAC/w8h7ZkX5sTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFC9HPPC; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFC9HPPC"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3cabac56b38so988237b6e.3
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722033477; x=1722638277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NamKfRr5DtJxVxIFQPJ6TuNsJh1PqVsocMWMEysLyu0=;
        b=UFC9HPPCvgFxwclY405XrvNUdoQ1cl1juWuDYJjCpEINjiPN+VdIj7iXrFxYMQFXMu
         zhSwMPDlb8iMfQLosF1/Y0Pbz/2tM7kLdkuGEUUQDPq1Rxxd3tVLixquUt4N0gDPBKw1
         UsuFcPt805c+eWtKjl1jFg9Op9LDpfEQXVQtzN3xoKNy49Dal3GFcbkk4d43wOn5098v
         qeo0FDZ+CeJtUSO69Zx3TgoXDN9jGUAIOxFM1pirJJ8Fo5u5DoX2tHJmCAsk7x8HvA+Y
         p14+N5ATTXRQq/L4u6WlQwLgOYEMbhaB0AcwfVI0fmjgZd+kjWG7XyDARP203mJ8fzUy
         oGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722033477; x=1722638277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NamKfRr5DtJxVxIFQPJ6TuNsJh1PqVsocMWMEysLyu0=;
        b=fsNOspEbdB52Rvl90DoM/Zxv6vpb3L6dskxEfvZYmrLG936OkzYGOHOgrsevA+ig7W
         Fi3cHBc+tkcFmomKeynYxfUMShHFoWpNcOCtaB5ZurbjPtvZ470YspLvod2OuCoQ8c2L
         033x/T/+I+wPnKfcWGk0KpmhGOuFR2SIm806As5tXP3E3q/+mYsGGy/jajgczeftob06
         a+kcjUZoa6wb1nT0lFJG0cM3JCBbVsCKayMOB4bPl0xdMVvwkOP7x/jNELc9saE6tR83
         5PxG2qH3rJf+14Z0yjkPJxj1pQGPU9LhkEYBhJPtKpXXc/vtY2dm2754+MKlTze4TTUZ
         octw==
X-Gm-Message-State: AOJu0YzgrOurSj8zaH7gMzpZYQ3rEjrI86nLAq7ZTXQzgUyRbVnIs8jF
	MeorOD/dmG8eAEEzTgWu+c8L6PZDzl6gCki5dK2UBZanmqI9Li8VR6Irpw==
X-Google-Smtp-Source: AGHT+IH7Pf7/avhq14zVcXNU/m7zjsJMyA7kB5po1BEnZQd83IDk2Dn98Ogu3yZaZZpylu5iF9hi9g==
X-Received: by 2002:a05:6808:1821:b0:3da:a97d:3579 with SMTP id 5614622812f47-3db23a87735mr1546595b6e.16.1722033477309;
        Fri, 26 Jul 2024 15:37:57 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db13521040sm892574b6e.46.2024.07.26.15.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 15:37:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/3] netdev: Update to the new l_netlink_send API
Date: Fri, 26 Jul 2024 17:37:44 -0500
Message-ID: <20240726223754.159303-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726223754.159303-1-denkenz@gmail.com>
References: <20240726223754.159303-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 2d70fc38eea9..e27a0019b7ea 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -6093,23 +6093,19 @@ error:
 
 static void netdev_get_link(struct netdev *netdev)
 {
-	struct ifinfomsg *rtmmsg;
-	size_t bufsize;
+	struct ifinfomsg ifi;
+	struct l_netlink_message *nlm =
+		l_netlink_message_new_sized(RTM_GETLINK, 0, sizeof(ifi));
 
-	/* Query interface flags */
-	bufsize = NLMSG_ALIGN(sizeof(struct ifinfomsg));
-	rtmmsg = l_malloc(bufsize);
-	memset(rtmmsg, 0, bufsize);
+	memset(&ifi, 0, sizeof(ifi));
+	ifi.ifi_family = AF_UNSPEC;
+	ifi.ifi_index = netdev->index;
 
-	rtmmsg->ifi_family = AF_UNSPEC;
-	rtmmsg->ifi_index = netdev->index;
+	l_netlink_message_add_header(nlm, &ifi, sizeof(ifi));
 
-	netdev->get_link_cmd_id = l_netlink_send(rtnl, RTM_GETLINK, 0, rtmmsg,
-						bufsize, netdev_getlink_cb,
+	netdev->get_link_cmd_id = l_netlink_send(rtnl, nlm, netdev_getlink_cb,
 						netdev, NULL);
 	L_WARN_ON(netdev->get_link_cmd_id == 0);
-
-	l_free(rtmmsg);
 }
 
 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
-- 
2.45.2

