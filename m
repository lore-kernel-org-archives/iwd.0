Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB199AD58
	for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 18:51:50 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id h14so415522plf.10
        for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyEK5RiSPuz00aRQ9dBmyra9N+127tkNbvkssK9SNDw=;
        b=RwcPrku3ZWP2D7uXLet0sLmVUYylo8K/d7x+Dhk/Wb03qSC5oO49B9EXtAO/DtnTHX
         1++KqRhAa3cqvpN1Gunl4GH2ZwbMgOvqd4ISf+5/vRgBDukn35M1ybzdxP0CXrKg0yve
         DoEe6fhkr4u8SinvTSubWRLYciCx5F0mARRxf/3kLY2bAEYDxtIF1UaHJMv9Enm6R8hA
         qKhB47v76szlfRwKLLXxG0OyVbj6ookF4q/FzyiEvsscSgG4swhnRNrayuQiRZhBSc0s
         48DIneKM4EfKmuqkBiB4Jw3cIFprhFJzQuPZ2yMxAvSHcWREnj09stGOJSC9d9MwJXGJ
         AKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyEK5RiSPuz00aRQ9dBmyra9N+127tkNbvkssK9SNDw=;
        b=CRzr192DXXn/fMNr7gNw33Bs6vwDZZjhIDYCGzahqdur5u+6x1WpGfkOFZY1O1HXO/
         SaFOU7aO2/sMeX3bZW0bXgsVQgN/Bzr8scBCqXDLTBDf/7HYxm4K0FnzIfoSdN27vlxW
         ihh0r251Ir/0ghTTROqLfbsRaKuez4z4sjKBDM7vnAZFFGXpSW3D3jQAnUOKl/FUPM+T
         9RxXFSY6FmL/DqXPQCizR06lqJBrQcCsAaYYYE9R7IfoYK7JZeCDZKiEBaSnWauSFZFA
         eMh9SeQyhr9vD3aa7SJ3SY4HAtvgkwywuMjDnRgkEgnlOTn1QKFh8clggalYoAXyIgcI
         iNyQ==
X-Gm-Message-State: AO0yUKUqQtTIW8jB7LLrpxezXD+Z6DtRs/xU1NQVrwtvEzwBHtTcgn+G
	HGKj7hzdNpcigFOrBIR8XTbrh2DEycY=
X-Google-Smtp-Source: AK7set8KgUgidddBpDLmzWXqct/fsM8j2nS7bVfWtufvB7oiS+lwgLiKdohStxKURwh/UyXp6Skk/w==
X-Received: by 2002:a17:90b:4a43:b0:233:f365:1d0b with SMTP id lb3-20020a17090b4a4300b00233f3651d0bmr16776772pjb.5.1677264710165;
        Fri, 24 Feb 2023 10:51:50 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id b26-20020a65669a000000b004fd50189885sm8406550pgw.91.2023.02.24.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:51:49 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] ap: handle -ENOTSUP when getting the GTK
Date: Fri, 24 Feb 2023 10:51:47 -0800
Message-Id: <20230224185147.1462945-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230224185147.1462945-1-prestwoj@gmail.com>
References: <20230224185147.1462945-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some hardware does not support this, so use a zero RSC in this
case rather than failing the association.
---
 src/ap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

v2:
 * Instead, jump to the !gtk_rsc if block to memset and set the pointer

diff --git a/src/ap.c b/src/ap.c
index fee5a6c8..398e469a 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1499,14 +1499,19 @@ static void ap_gtk_query_cb(struct l_genl_msg *msg, void *user_data)
 	struct sta_state *sta = user_data;
 	const void *gtk_rsc;
 	uint8_t zero_gtk_rsc[6];
+	int err;
 
 	sta->gtk_query_cmd_id = 0;
 
-	if (l_genl_msg_get_error(msg) < 0)
+	err = l_genl_msg_get_error(msg);
+	if (err == -ENOTSUP)
+		goto zero_rsc;
+	else if (err < 0)
 		goto error;
 
 	gtk_rsc = nl80211_parse_get_key_seq(msg);
 	if (!gtk_rsc) {
+zero_rsc:
 		memset(zero_gtk_rsc, 0, 6);
 		gtk_rsc = zero_gtk_rsc;
 	}
-- 
2.34.3

