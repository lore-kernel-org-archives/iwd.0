Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A6569D
	for <iwd@lists.linux.dev>; Mon,  3 Apr 2023 14:19:40 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id x17so38327674lfu.5
        for <iwd@lists.linux.dev>; Mon, 03 Apr 2023 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1680531578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHv7g61vaTo8yK9lr0SQ7xSPzYi2Tcy37t7Ld7JHCHU=;
        b=U8/QuXcYBV8R4j7S4Dji4r5kxEB4r1yMElMbUjL4WK6jzrsud5rF4/ksfNJ/yunZ6q
         KHcILP0gmjEve6fSCWej3RU6EgPimRH5U+URBbCAMowvqkjSstkyTS7/ZfsKBtDmptG8
         n4/kOV2P/ZMTJnCOeVU/cJU2i+ag3cxF5Nd7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680531578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHv7g61vaTo8yK9lr0SQ7xSPzYi2Tcy37t7Ld7JHCHU=;
        b=1SCJY2ezxiIRwvJKWaF5h3Gv31CvXBp6svV73opUDjzb2WcZkp4uvO0IrQt1nF+lFv
         A40ENlKdzPWLah/bn7EB6UujkF10DacvRQEuVCtJWIsZtsU3OWYdO4fAmQ+wiqPftOYG
         bit9h/44fk60omTINWlr8Azd+NnppOc5ZG1X9xdNSMwHo1ArckbR2P3dq0d97b3jJwHE
         IKnP3/Vw8F5JxGylsVyBwjTKp3PLlaumkxHAicH8w8kbn+UvEB/GO8bpvyJdWqQJikC/
         +CdcaN5Ba4frXg+aR9EQfc2sN5SK869QyNOvAnElkQrs7euB/e16OMYsUJvFkgttWCM2
         LTww==
X-Gm-Message-State: AAQBX9c1U8rxcgwphVwegopbcp6vHEJUPnsNqeG+Z8R8DiLfwGWDQ0Zy
	V7HbM7vdC4vBq3S7vPANDs3OvUYqUVPEnfxoR0o=
X-Google-Smtp-Source: AKy350bcdBQLyXmSZxOU6sSK/uFKAxmjaPvy4g91akoxq9iwUFu5BI73kLxIUYBZ4wkRJA4y89m5ZQ==
X-Received: by 2002:ac2:4186:0:b0:4db:38a2:e985 with SMTP id z6-20020ac24186000000b004db38a2e985mr9897794lfh.62.1680531578195;
        Mon, 03 Apr 2023 07:19:38 -0700 (PDT)
Received: from localhost.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id e23-20020ac25477000000b004db3e330dcesm1792101lfn.178.2023.04.03.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:19:37 -0700 (PDT)
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To: iwd@lists.linux.dev
Cc: dika@bang-olufsen.dk,
	clca@bang-olufsen.dk,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH] station: handle ROAMING state in disconnect event (again)
Date: Mon,  3 Apr 2023 16:19:27 +0200
Message-Id: <20230403141927.235014-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The blamed commit clobbered the non-FT (Reassociation) roaming case
in the disconnect event handler, causing iwd to potentially get stuck in
the ROAMING state after a failed reassociation during non-FT roaming.
Add it back.

The subject is inspired by a previous commit which did the same thing,
but introduced before the new roaming states were added, namely commit
8758cc89487b ("station: handle ROAMING state in disconnect event"). The
rationale here is the same.

Fixes: edf556cc7bb9 ("station: add two new roaming states (FT/FW)")
---
 src/station.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/station.c b/src/station.c
index d5650a2995a9..69f9be79880d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3201,6 +3201,7 @@ static void station_disconnect_event(struct station *station, void *event_data)
 					event_data, station);
 		return;
 	case STATION_STATE_CONNECTED:
+	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
 		station_disassociated(station);
-- 
2.40.0

