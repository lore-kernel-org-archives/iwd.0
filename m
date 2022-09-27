Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538404C86
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 23:15:54 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so188866pjh.2
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3qUJWxkBTbbULDpAU1gBxkyt9fcNcfCyWjdRtPurZ6M=;
        b=JLI4O3UZOdT9Vhoyjp1pRwiXQwDqDZ1H4aikV+4T7jfQN3Mr/20pXGFk/zeWARusmW
         m0wgqsFBYZmpja4unOtNJI/DP0gK/XdOadyBrhxFF31iZZwp6f/yqHJT2zQ8Lv+zp4A6
         +1dKXSLNR5Hhp0+L1TFRBLSOKmqVjke7QSMQ+46CeQUGSQcVlWrTdOrp8pG+C3rCIp2e
         5y1qTE0OLqpou5+69OjVkf1l/wQDPrB2oqhHf/+EwBvyeM1bbY9lAOkOHwNK6WVAat+l
         fiCLkesBQOh7Yt6klbqN1gUNnOJ+37jgwEiL4wZ34y21xXTb5ytt86num6+IcauwEqZd
         7KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3qUJWxkBTbbULDpAU1gBxkyt9fcNcfCyWjdRtPurZ6M=;
        b=cakKs9eJ15nE4JHTxi2qHBYmIUTJz31K0aVMvr6/9SlYPxnjbDVtcGFRM2GM6sFcWh
         zk8kk5Pzs8L+4Lb1CKTJad3pNELpzw81QLxTPcaziFaWCbuUGSVQicvqcGhKc2AlpPXQ
         1lyKLZoegEPkpharmoBIzAdOeJL7IbPPEARMZ7YJ8r33LQVKPXnCXVfDjXdz2YyaYV3e
         biiiTYWT+gvXg60DP8+6ZBYeMddA/j2i80TQxrekuaxFn+sTc2NRqWQdwW0LGZ0ztWdG
         /9TWsL276AQfHM6xu45qpJWeX0sBLMv3jKpv8ctVLPgUG+2XuwH4fw8KVfK5Ao4zUl6d
         eEUg==
X-Gm-Message-State: ACrzQf1oTpvTVHaWVcKOqgilHil62kHI9RZSpf2MK5Xwyu15H9cFNR+0
	GJALTHZMY7aKODV9aO/XX6kTlRQc5MI=
X-Google-Smtp-Source: AMsMyM7e15ZsekOovvbBCtJTP31LGX9yGNlNdCaOCTJrDfuwxQHTFUswyWnFXRF+IzqnKdsoeqoZ3w==
X-Received: by 2002:a17:90a:1b43:b0:203:70c0:9f60 with SMTP id q61-20020a17090a1b4300b0020370c09f60mr6873781pjq.184.1664320553388;
        Tue, 27 Sep 2022 16:15:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id c67-20020a624e46000000b0053eec4bb1b1sm2345349pfb.64.2022.09.27.16.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:15:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station: handle ROAMING state in disconnect event
Date: Tue, 27 Sep 2022 16:15:47 -0700
Message-Id: <20220927231549.310800-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This both adds proper handling to the new roaming logic and fixes
a potential bug with firmware roams.

The new way roaming works doesn't use a connect callback. This
means that any disconnect event or call to netdev_connect_failed
will result in the event handler being called, where before the
connect callback would. This means we need to handle the ROAMING
state in the station disconnect event so IWD properly disassociates
and station goes out of ROAMING.

With firmware roams netdev gets an event which transitions station
into ROAMING. Then netdev issues GET_SCAN. During this time a
disconnect event could come in which would end up in
station_disconnect_event since there is no connect callback. This
needs to be handled the same and let IWD transition out of the
ROAMING state.
---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index 4e07ef19..c3f3b383 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3172,6 +3172,7 @@ static void station_disconnect_event(struct station *station, void *event_data)
 					event_data, station);
 		return;
 	case STATION_STATE_CONNECTED:
+	case STATION_STATE_ROAMING:
 		station_disassociated(station);
 		return;
 	default:
-- 
2.34.3

