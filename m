Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737544C96
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 23:15:55 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id b23so10977817pfp.9
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 16:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=izPUVM0zy5ff8kD5uJl7DhB6dOs5+FosR6ZhTjrT3bo=;
        b=OGhRDLF71Tw7/yYUsWC1l3YgovemhATuUqmNn4892qVVJssv3lV6iQXw7ZdOs+3VWc
         t6ndrzrsZmwE0lTSQLHgd0F3aURekBWZVkpxgcZeSzA286fxotknT0lrAK4JNMiF2v1P
         UXISOMas5WpB9ywwDZ4U6K9gFHIayQpEcYqFte3czPo1eFxAxnVejrx+vQayLV5dYC1b
         q32bgfggklxqFjx6IQQTZ+ZGpls1bZsPRqNgOymTcTyYSEDthF/36pIHZVz5tHLWuiKN
         qN2u0ut2UeMv3bsXY+FAqg4hpW6aJ0WQuV3iHsFavXCc0OkOff5MBWGGmDbOMYvceZIB
         b8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=izPUVM0zy5ff8kD5uJl7DhB6dOs5+FosR6ZhTjrT3bo=;
        b=fooI06Sz2t6gW9u6zGnwM+BEQY8cE+ck5yf69WCggOLBYJJMVBX0CM9cqcgxnmrF7i
         OUZzlO9EIoz+8kdq2BmWH4osX5JjEzG1WVanhDEysavOnwvp00ywZJAhUl4+NobOOdvn
         6nHrGCHl0jsdqCkyGyaNQSNSUi3VcRYJAPFLZUkec0DxD5Ws19peA5ivR0qTtoEPaYNk
         pxFMnCFr0Pg4nyObNTcC1ODhXdp1BB6MrtxtPZFc+BxHXzrWRv5baXC+aoD1T0KhgkpN
         iLK707TwhhUXjQAcEdLp2eZ/1pO+2VWkgATh7O+ZSkMl1KewTtROBNorJmif2wvyubKQ
         Y22w==
X-Gm-Message-State: ACrzQf3LHg3blZXY5mTiGoqzZOq+PVoj2ye/JfSmMUzrivDXJxwGfuFw
	MebSASFsAjDJMNM7CRv1OEJKByyhdzg=
X-Google-Smtp-Source: AMsMyM76ceZixRrgP1u3CvFDYxIIuhQQc9WBlBh7IDUe6VG7B1pBTFemxbqYz6T/agoI4YwrcstTmQ==
X-Received: by 2002:a62:8345:0:b0:53e:a1bf:8df9 with SMTP id h66-20020a628345000000b0053ea1bf8df9mr31616506pfe.68.1664320554854;
        Tue, 27 Sep 2022 16:15:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id c67-20020a624e46000000b0053eec4bb1b1sm2345349pfb.64.2022.09.27.16.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:15:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] ft: fix ft_associate to verify if authentication succeeded
Date: Tue, 27 Sep 2022 16:15:49 -0700
Message-Id: <20220927231549.310800-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927231549.310800-1-prestwoj@gmail.com>
References: <20220927231549.310800-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ft_associate was only checking the presence of the info structure,
not if it actually succeeded to authenticate.
---
 src/ft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ft.c b/src/ft.c
index 5b53810a..cc13d2bf 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1055,7 +1055,7 @@ int ft_associate(uint32_t ifindex, const uint8_t *addr)
 	 *       a different BSS.
 	 */
 	info = ft_info_find(ifindex, addr);
-	if (!info)
+	if (!info || !info->parsed)
 		return -ENOENT;
 
 	ft_prepare_handshake(info, hs);
-- 
2.34.3

