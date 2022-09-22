Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3118B23
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:16 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id e67so4396614pgc.12
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3Bp63x6eLqSraGGYCDXjXv2hd3AKc3vVUiP/PrH1i0A=;
        b=a36MIC2BJ+6xZfVkj9MVHogEqJDYcRHsFgOwJDvkbZzjAog4OFDfrLxyS8oTzsLKK8
         7vCXA+lvfPLY2xS4v/4y549qBZPqrfJAf4DCZqCdVwZVtD4HcAkJARARkvhRk7TRfU7s
         RgoVZywCWGT5TpXSsN5ooyomN63GTwQwG4aYHgI7VC7hjypu2+63sewOtTbuvcDzajd3
         CPZpSR4n+XMyJqGnTH0WStNJWdDO9TWkNvqqdFk3NPDGmXDJ2tyUaBtHQlaDXJ2Eviz7
         s9oHZtODUiWQeN5XxSYHc1isKApI50twsBl4pRJ4qxfY9baLuNnghaJmKHMaduhLGShj
         J8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3Bp63x6eLqSraGGYCDXjXv2hd3AKc3vVUiP/PrH1i0A=;
        b=IiJNur4Dpz57TmpAUT9aaTBZluQDKQSAtGGH7nKGO7x3ptN5DzL/f2sTlBr9ojZq5o
         wH9fQDQff271zYXFuczfWh9QkTRggL7TXPwLtvQuaXfzHcyoGv1J7TgKg7AFmh2CMa5w
         XVLqdIrOYxTToY7fsx0jz0w5dKt8QYVzq2xyofJRGlbgx4/ajKh1rZv01lDrtJfBiniW
         D8mFb5ZOsIYxLvIhjRqplHwDXjOC0EdyPfd+7SRaRw/czsalFqrjgx3PMSZXW/4/apWL
         vFOs5wUcDwoPQ0dkffuiqyvrONFqwt7UWPHnZSDz4xQ8bQmGGrw6xrkhuDEXh5QKAupp
         RYtQ==
X-Gm-Message-State: ACrzQf250Ymh1o0yuD57vMNoycLZFz4AcSVQJXFsrvU46IzTzJ8ZBGNd
	iW+QCS+b9pHEMY3mCIQ643ksW1PDalg=
X-Google-Smtp-Source: AMsMyM7oYZlcCbOpBFjKiGHpn7V2eiF9ujtfpZ447dKgse+XSn2XxmiNCpC+mSmRpYaQUko2IyBJ8g==
X-Received: by 2002:aa7:9605:0:b0:53e:8062:43fc with SMTP id q5-20020aa79605000000b0053e806243fcmr5793983pfg.39.1663884495833;
        Thu, 22 Sep 2022 15:08:15 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 07/11] station: handle NETDEV_EVENT_FT_ROAMED
Date: Thu, 22 Sep 2022 15:08:05 -0700
Message-Id: <20220922220809.862022-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220922220809.862022-1-prestwoj@gmail.com>
References: <20220922220809.862022-1-prestwoj@gmail.com>
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
index 991c8394..5f5838e7 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3141,6 +3141,10 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
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

