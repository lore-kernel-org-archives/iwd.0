Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61634C64
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:47 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id y136so10614379pfb.3
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EDqFw+o+0Mt9VUZDYVoWiXj0o8r1cQvvpq2XyR818QQ=;
        b=I00gH4ty+HgSuUQvglmLkbwGQ5gusJU1Z1gCiTHmKwb3w0EIOMLKgVtmaFTOCAEPNt
         +V51HmJ6qSy6/wtDbKWeMxatBMmAIvkiKlnadTI9CuTpXNDT9MoWgSrgW5MEGu9JldPZ
         da1jj+H/HozwAMyQoqiaxO/ukb6ZuSiv62EPrNiWkLsOQ49chQE5jUUp8zn4RASfLhmZ
         OZ2vw5ZnHaUYYK29YH/mS08ObLo9z+XcoNzDkBaHa+ZjTj8n75ihXhZStnJNj/5EI+jy
         Az9E/j1iuRkXNreOuTC6yZfb7vzezMI5jGbZ7t9ggaUnwcwTl/+W8mQHCMPpZw2UsjC4
         y6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EDqFw+o+0Mt9VUZDYVoWiXj0o8r1cQvvpq2XyR818QQ=;
        b=c5quFioeRAkdQ2HlROmylgUElW+xaLwQ5YtDWzDfj08m+mXSpX3Ij3MHbGGR7T01Xf
         lfcB/aZUgTt3Z4cVEuBMs6vs039fLxNKtc1vzrykQw3LLXrmjJ9NbW/clb4xI3q2CN57
         Nl7odvLSyMIx6wChkFK8D7sShr0leLzuisuXs/TMv7PT3y7vUdefBmHaiEXXLeH+ojW+
         eCg3Nr86HGL1hxiIrXWkX0dtwuFrFfNqvTTpZPOZaNZCCcvhXpfqzosT6Wugn4zuIKI4
         G5L9szrXci/7PUuDZnZUeq1S/nxayEWcSKFpscA40FtmIUMdOWkAngC2LXDiUe/TlXy6
         2QJQ==
X-Gm-Message-State: ACrzQf0bCa5PT2hvuA7LrHfWYjTARmYCBeVq4QVxLwCIoIky+cyQVypy
	I4SGs6GxUmmzPsQT0y8cah8lV/fwPSs=
X-Google-Smtp-Source: AMsMyM43X2AtK3lqsd7HdUozGNM87mxrp4BkcjMcoDhCpsBtXZ1qO3hSDCpBwnco8GJHVe/T7UeM3A==
X-Received: by 2002:a63:ed18:0:b0:439:4176:3ea6 with SMTP id d24-20020a63ed18000000b0043941763ea6mr25594684pgi.363.1664308067042;
        Tue, 27 Sep 2022 12:47:47 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 07/11] station: handle NETDEV_EVENT_FT_ROAMED
Date: Tue, 27 Sep 2022 12:47:27 -0700
Message-Id: <20220927194731.269732-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927194731.269732-1-prestwoj@gmail.com>
References: <20220927194731.269732-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index ced7c2bd..a4681ce0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3176,6 +3176,10 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 		station_packets_lost(station, l_get_u32(event_data));
 		break;
 	case NETDEV_EVENT_FT_ROAMED:
+		if (station->state != STATION_STATE_ROAMING)
+			return;
+
+		station_roamed(station);
 		break;
 	}
 }
-- 
2.34.3

