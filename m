Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661B23D78
	for <iwd@lists.linux.dev>; Thu, 18 May 2023 16:50:09 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-757942bd912so123164685a.2
        for <iwd@lists.linux.dev>; Thu, 18 May 2023 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684428608; x=1687020608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMNDXCtv1dRZ3EhNXLekDDNKFmZKuaqafsL8saIA0xY=;
        b=drqW9NiPQlLN7WPyO6BU5IDAv1EuBV27GrX9ahRXlwO4lIFR/IG5CaItaeCfIEdj0e
         zJpdvrExNsAMSbhaCXnG9frcSgmBkve4UttJNaXU777X3LOZ9CT/Q77Rd/0+ps60o9TX
         ES80Cv5B39coNu/Tu67AMa38c3TMEe13WYZaZ2NiSJ0FvZHOVovJLo/z/W2AOq97K6Mp
         9aEYupjDM09/7QjvD5+IfpemofPMc1ERS5gQSCAnPV3r+qeIoU4995MVPf9e6Zf7ATjq
         WESdeItk7C79XPk0s3rXkYwVwGNofszeepYckiQnpHRgCRK3O7ir3Kii7V0OLBZyX9EU
         X/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684428608; x=1687020608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMNDXCtv1dRZ3EhNXLekDDNKFmZKuaqafsL8saIA0xY=;
        b=ifgUC1sxZ57lCWcL0XW2Q1fDQ01Hw/9KzuSJqFpbz23dl379no60epxF0TAGHnPAZ/
         IyZrRMCt3Q/IlKSSiNHoDwFYcbhcID5L7I6R0sMjMsabxQUidGSS/JjcnVKe7uQA5tAa
         0AzHggTkEU6ZFj1Km1hkn40zZMpVrUQdBESnmaKiL9Ls2oW7PH75bVBbIhYTMS53HZQ7
         bkD+opFLGM3nGfsjmBuBZYuOUd3z8LAG8K3OPWbwN/ShmKgqGa+U8RpiYH5yVyxe9JL/
         lhsEHYDlx5u+FxU1nZ0rGzVMfWfIV1BOdUZoUz4CryMs8+TfjuB86MknkQTbbctu+ArP
         H5tg==
X-Gm-Message-State: AC+VfDzFfSuaufck/myqrBYAw548Oyw9n+Wub8s+DfoCFvvG7UhJaBwK
	6V0LIntZQ0dWPyITRq/wq5HyxiXl0/I=
X-Google-Smtp-Source: ACHHUZ52PTirPzzIJ1025ZEWfCDNuzyFSZRnJxXPghkjsnoEbUSt1OtRyCWFELdVpCOeU3UF0Vlmlw==
X-Received: by 2002:a05:622a:447:b0:3f5:1ff7:db72 with SMTP id o7-20020a05622a044700b003f51ff7db72mr550292qtx.22.1684428608369;
        Thu, 18 May 2023 09:50:08 -0700 (PDT)
Received: from LOCLAP699.cardinalhealth-columbus.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id cn13-20020a05622a248d00b003f3941ba4d9sm626112qtb.32.2023.05.18.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:50:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] station: use wiphy_radio_work_reschedule in FT path
Date: Thu, 18 May 2023 09:50:00 -0700
Message-Id: <20230518165000.275611-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518165000.275611-1-prestwoj@gmail.com>
References: <20230518165000.275611-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If FT fails the work item needs to be rescheduled rather than
inserted.
---
 src/station.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index be571083..f830ab7a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2330,8 +2330,12 @@ static bool station_fast_transition(struct station *station,
 	ft_authenticate(netdev_get_ifindex(station->netdev), bss);
 
 done:
-	wiphy_radio_work_insert(station->wiphy, &station->ft_work,
-				WIPHY_WORK_PRIORITY_CONNECT, &ft_work_ops);
+	if (station->ft_work.id)
+		wiphy_radio_work_reschedule(station->wiphy, &station->ft_work);
+	else
+		wiphy_radio_work_insert(station->wiphy, &station->ft_work,
+					WIPHY_WORK_PRIORITY_CONNECT,
+					&ft_work_ops);
 
 	return true;
 }
-- 
2.25.1

