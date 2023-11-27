Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE13137D
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIGlhuy3"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b8672b9482so570021b6e.1
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 20:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701060014; x=1701664814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+3nt6i9o0eudaWV6sZTz1qmMdElTUclhcOFjt0jYP4=;
        b=cIGlhuy3TrqYrAtrkX0nkuSawclw7tGgfWyEHtimLWw6qQYS233IAd+zw/NZsUWWzL
         6SgSLgnrU6dbybx1b80fQj3VobG878ZL/Q/cBdSvMI8pc6/AeHF0d4LD0odTNtb5ry4/
         wtAJkZzDIEMZ7+nckSd/BBeyb8jQX+1wPcZ38FBYo4AX9KOS+zWSAMblN4sLKQDGd5+T
         bD/rOUv3FTGwI1xcZ3H+rnoj9pHDh1OV+Dn5kuc1Qm1JZqoBShmQvimAQtoY3ojFNplC
         EmMj5JBh2raOMqbUsKikGCoPDz9EoO6mbcTvjVfbPSIkEDTGVwYxHC9S3W6pFAXKcs9X
         8kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701060014; x=1701664814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+3nt6i9o0eudaWV6sZTz1qmMdElTUclhcOFjt0jYP4=;
        b=UsNuUMItCUrzHL6DTVsk3kBpE8D60Vv9m8xRXj3RNXB0MIkpEPsoJ3qN2dLlq+RcSG
         gvSXzP25T9RdhF3jqhVcFsYjIAa9rrTCMMkGYLr5kpr0H4WcKGI5nz2dwiMZdN7jN81H
         SrfNjtbnb6ngd1ioHp82PHIJRVTgPXkFdiQZ2g9LWuuo2c9IWVD0sdNyM74eUYe8lzrL
         9pgJ/25oKI5B0WgWMUnOOYUWwXF9xGAM6QkOUekC/doencpqgBlqMDFQ7RqJR8M8FPtv
         vLbtY2hg/ujri6ijYGLAR0JdtM8T6Dr/cim2qbQL+qb6uSL4DGZ+JtAPHtYUfTbTj9Wu
         ZULw==
X-Gm-Message-State: AOJu0Yx++cL3+O5pN0+kjB94Kt8tPdRFApKgFQK+uAHOfPPC/Ubd8qLP
	8pLTWFK69aP6iIIW2UT9Bgi177RtDd8=
X-Google-Smtp-Source: AGHT+IEPsOlv1ZdPChthlN5aIiX9IMmAlbfX9Vx4Mv6aSySjZruduRdqilE750ZV7BtnJFI0Tuyhdg==
X-Received: by 2002:a05:6870:d628:b0:1fa:cd2:5942 with SMTP id a40-20020a056870d62800b001fa0cd25942mr10203762oaq.58.1701060014294;
        Sun, 26 Nov 2023 20:40:14 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nq6-20020a056871378600b001f5d5930e85sm2110558oac.33.2023.11.26.20.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:40:14 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 4/6] netdev: Do not leak l_genl_msg on error
Date: Sun, 26 Nov 2023 22:38:44 -0600
Message-ID: <20231127043924.1328538-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127043924.1328538-1-denkenz@gmail.com>
References: <20231127043924.1328538-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In netdev_retry_owe, if l_gen_family_send fails, the connect_cmd is
never freed or reset.  Fix that.

While here, use a stack variable instead of netdev member, since the use
of such a member is unnecessary and confusing.
---
 src/netdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e7b502b1c3ba..901a41900350 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2561,23 +2561,23 @@ static void netdev_cmd_connect_cb(struct l_genl_msg *msg, void *user_data)
 
 static bool netdev_retry_owe(struct netdev *netdev)
 {
+	struct l_genl_msg *connect_cmd;
+
 	if (!owe_next_group(netdev->owe_sm))
 		return false;
 
-	netdev->connect_cmd = netdev_build_cmd_connect(netdev,
+	connect_cmd = netdev_build_cmd_connect(netdev,
 					netdev->handshake, NULL, NULL, 0);
 
-	netdev->connect_cmd_id = l_genl_family_send(nl80211,
-						netdev->connect_cmd,
+	netdev->connect_cmd_id = l_genl_family_send(nl80211, connect_cmd,
 						netdev_cmd_connect_cb, netdev,
 						NULL);
 
-	if (!netdev->connect_cmd_id)
-		return false;
-
-	netdev->connect_cmd = NULL;
+	if (netdev->connect_cmd_id > 0)
+		return true;
 
-	return true;
+	l_genl_msg_unref(connect_cmd);
+	return false;
 }
 
 static void netdev_connect_event(struct l_genl_msg *msg, struct netdev *netdev)
-- 
2.42.0

