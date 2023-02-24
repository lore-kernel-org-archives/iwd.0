Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6F3AD4C
	for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 17:59:32 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id l1so6917069pjt.2
        for <iwd@lists.linux.dev>; Fri, 24 Feb 2023 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5vf6UmJRsnhK2mt9Sfe61mlWwvC2go7Xxu2bsKS9tc=;
        b=JHCA32qKlR//16+/ZDvEC2VG02wzKBFxuV9YUYio9t+cOsQorHo/6v/WQbSHmuEClh
         ZUe72MonaN8Iz8FfRQf4cME09OWsmU4x/xPft6Lt9ueftLGSd8LLyf3kZYZRuUycpNQz
         YeMoa2cz3iSOZ99+ywDNTy+TZSGpCG6lD3GjQLZhWGi4i3yIFVYTZio2q1xk+f3wMIE/
         FjC9fMyoHemc8gYSNCop91vsd0Wl1xlCIq7j9Z2UQOTZB+LcNXwoh2Ei9wU7ipZPk4zC
         RfreviPSr0LVOqSv4rJiBIG16nPxChodrph9vjmPvWKvHhkd8WNKPODUWwiEypLLFbx0
         pjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5vf6UmJRsnhK2mt9Sfe61mlWwvC2go7Xxu2bsKS9tc=;
        b=Wn3CH3PpXpHBkrgbg/KxtYxeuvtOlCK86/XPTNS6iUGqw8S1njT2Wh0RfRzSZi8Eyd
         1yO3d/0Z4zVEoeumRgj0M6xSe3G9AgFo2AR7ju+OLPMCZuaUou5ueTxgdQFWL5/mdYwn
         lYV+wzyunY1It6/xg3FGstwu7XflhL3f1NutChbaI54IUfO5fHzDbMs7Ok8u45FzRMr9
         EjssEVrA3cCVpm4d+Dg8D92Si+zqu8+i49m9dc2BupXnnbIW85RbiesuN5pfABXOHPfi
         xMuOkrkBwYkWmeQYAlv+/yUSQf440jhw1WftVTxH0pRMP+KwAi8e6yncqLTpD1FEPlz1
         vngQ==
X-Gm-Message-State: AO0yUKU9e/DPyBdQxESIzuAo1YIKt7P0q+qepumJzAsXvX8G0QUp+Lqv
	Hf6CKn9wjvGtKEWplyk11byN7VYo1Vo=
X-Google-Smtp-Source: AK7set8/QttCO45Av8GMO5ebHMTjq9JQalbwiycVs3fxgpZQEf+AwrXumOxvpFovwY7YIB3pny1YdA==
X-Received: by 2002:a05:6a20:429a:b0:b8:723f:e21b with SMTP id o26-20020a056a20429a00b000b8723fe21bmr20646326pzj.3.1677261572315;
        Fri, 24 Feb 2023 09:59:32 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b005a8f1d76d46sm8763749pfa.13.2023.02.24.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:59:31 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] ap: handle -ENOTSUP when getting the GTK
Date: Fri, 24 Feb 2023 09:59:28 -0800
Message-Id: <20230224175928.1460558-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230224175928.1460558-1-prestwoj@gmail.com>
References: <20230224175928.1460558-1-prestwoj@gmail.com>
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
 src/ap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index fee5a6c8..aa1ae543 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1499,10 +1499,15 @@ static void ap_gtk_query_cb(struct l_genl_msg *msg, void *user_data)
 	struct sta_state *sta = user_data;
 	const void *gtk_rsc;
 	uint8_t zero_gtk_rsc[6];
+	int err;
 
 	sta->gtk_query_cmd_id = 0;
 
-	if (l_genl_msg_get_error(msg) < 0)
+	err = l_genl_msg_get_error(msg);
+	if (err == -ENOTSUP) {
+		gtk_rsc = zero_gtk_rsc;
+		goto start_rsna;
+	} else if (err < 0)
 		goto error;
 
 	gtk_rsc = nl80211_parse_get_key_seq(msg);
@@ -1511,6 +1516,7 @@ static void ap_gtk_query_cb(struct l_genl_msg *msg, void *user_data)
 		gtk_rsc = zero_gtk_rsc;
 	}
 
+start_rsna:
 	ap_start_rsna(sta, gtk_rsc);
 	return;
 
-- 
2.34.3

