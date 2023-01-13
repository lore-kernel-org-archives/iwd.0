Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0BBA40
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 21:24:39 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id g205so23843pfb.6
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3Fle0b1C/5deDtOKS/XGVQ8cgD61aKMGhbCYYDZPQM=;
        b=FCIgKdKoMcMDDQB8h5UW9yTvzHxABCiRr8pElMmYw4n2W+KVFkQb3EGSQpWrIPEt3S
         dZ2UHLJl1MNDOlBfPDKdV+Nr48i8zf69zMQeVpayJVPAdbZ5JFxewhl8dG6whoYmmrI7
         DT7wtHkqhWBtkb6Y11QG2+vz/XIxhg17FL0B/kOsant+ZastrdcxiGHEFwRrnADIlfUH
         VhDOPW4dxGtUI3uxMymGfzrhFZSmk5kcWF0J1o9I78BBo8pudCQVL5lurIlVJlK63CtP
         UDP3kY2stDtVhMJUvCXK3V5y3kzeg+KrQtwVNNrWgjsKARf68sd0+zrnsMNYPSzkd6rI
         2guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3Fle0b1C/5deDtOKS/XGVQ8cgD61aKMGhbCYYDZPQM=;
        b=lw4XUhDPGf/ETuNLieTGm1sZpar5rE9nGFkeZLkcho6enDgbQmDwRaiHB4VGZDcc+o
         4L9Eh3VHtXcUB6FoNsLebrd9VqafF8iV5fEKadU8q/piScT5zU4Qs3wj1+WTmBhosOKX
         ZV5fYg3aARGSxVZnWMxWZkaPHUnHs1dOKReJaeokyCl5y0HG25oBnJz9S3VfrX+QseM6
         pGZuVBJ31j5hMkLDGofOJRqSwtbMnQvMNZrGIvaUrbaxMsrMdNZ6p0xYaPOwuI4UxT9q
         0d+rpzzCuigtmH57IzC3+YoWt6eUos8uuQzfDlm1wZkTMis1awfj5TlZKufNVcVnOQHd
         SoMg==
X-Gm-Message-State: AFqh2kpNkqq1HeuNUkvyY8rZESKYf5+j6RmdwVU3f60M5SQMNZapWWHJ
	e8lSWu2O8ZApMRvMP3P7OT6kSJNekFk=
X-Google-Smtp-Source: AMrXdXt+rFPwMcW74E/wnItI85dBKUwmaBB6gxpjbM7pqTtmPDf+02HeLjNsXJt3dC+UZVLdFN+Cow==
X-Received: by 2002:aa7:914e:0:b0:574:35fd:379e with SMTP id 14-20020aa7914e000000b0057435fd379emr78764060pfi.2.1673645078974;
        Fri, 13 Jan 2023 13:24:38 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b0056d98e31439sm14562829pfg.140.2023.01.13.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:24:38 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] station: check for FT work in station_cannot_roam
Date: Fri, 13 Jan 2023 13:24:35 -0800
Message-Id: <20230113212436.794519-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230113212436.794519-1-prestwoj@gmail.com>
References: <20230113212436.794519-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If station has already started FT ensure station_cannot_roam takes
that into account. Since the state has not yet changed it must also
check if the FT work ID is set.
---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 1a69b98a..ed98a8d8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2720,7 +2720,8 @@ static bool station_cannot_roam(struct station *station)
 
 	return disabled || station->preparing_roam ||
 				station->state == STATION_STATE_ROAMING ||
-				station->state == STATION_STATE_FT_ROAMING;
+				station->state == STATION_STATE_FT_ROAMING ||
+				station->ft_work.id;
 }
 
 static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
-- 
2.34.3

