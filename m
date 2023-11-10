Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17B1B294
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3w62pOE"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d261cb07dcso1224569a34.3
        for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699625785; x=1700230585; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIf4pwUkqQB6aGyGNSu0M2ER8NCbxYZBJPAIrpW44TQ=;
        b=W3w62pOEiO9QsOcY/RmmhfMhlM+PsRkI9riv9W0GBgm9NbqkSQRLgq4HQpKBFJL6MU
         8C1xVczgneGKo75geVnBWxw74wtOMi8OsM70SbTkyNVmBwpZl4OwEF8i22/WLtTwdtAf
         7lhscLFwkshd/saxEobMzVnIR8SvHtQf0BLoNuB+hRB9cSRCIc656WFNf1tdAbkK4kzk
         70bTbZxDCnbamqm5vBneGLvxheK0DgfdbiHa7fvt8muhnli0rtCnrXrRp/LV0+0b4P87
         hjsxeF/aMkqlN7l6ilkB8us01Ug6iN5yWNI3itrNVLUTlUwfmSvF91RPuHgowxasdMbx
         lMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625785; x=1700230585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIf4pwUkqQB6aGyGNSu0M2ER8NCbxYZBJPAIrpW44TQ=;
        b=vS7/4C0PiVjmpaZp/nwfKZFGIopfSP/iEK47fpWzvLDL8ttXLr9dk8eAzP/jTA4xKw
         0hAmEGpayaf9E7j8cWREL2NSaflTXJVtrhJbUGYBQkH6i78Ru8j30g6B/pZeA/uCVxZZ
         8AQ1XPO52ZUjE2ZHZgloZ828xb9/b7rdZJlfHm1w3sOFjXV0mjtAlY/03sQtV8Xk8MyM
         J/2Ee3GUQyXNMz3L1PVV/aqeMFAsK9BoL38Zby2N8HBDvIhxeKNp/9oqIKQV9z2L652S
         tRDuuwDhoPB+csiR3qpsxYIuXrMF4+rE5NuFtXoF+l4T/QLnLwRH72DikQWfww+/Xyhp
         7Kpw==
X-Gm-Message-State: AOJu0Yx8geSFroBVSdpy7Gs82Ug1f3vlvtkYTJFanOuS3Yk4JhvWp+AO
	TBXTS5TQlfzKmxzEATwG3WQqr4f960Q=
X-Google-Smtp-Source: AGHT+IG03RYcZ4ssmKO8OrWrq+iNVoRIxjXdqGoPNkjnezc1PeKmFTBJR/5EhbIHAZLfLfKr58OMkw==
X-Received: by 2002:a05:6830:145a:b0:6d6:4e2b:7e47 with SMTP id w26-20020a056830145a00b006d64e2b7e47mr411643otp.17.1699625785407;
        Fri, 10 Nov 2023 06:16:25 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c10-20020a05621401ea00b0065b11053445sm2958163qvu.54.2023.11.10.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:16:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] dpp: make station connected check better, remove duplicate
Date: Fri, 10 Nov 2023 06:16:19 -0800
Message-Id: <20231110141620.80195-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110141620.80195-1-prestwoj@gmail.com>
References: <20231110141620.80195-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking if station has a connected network set was fine, but
checking the state is more clear/explicit.

This also removes a duplicate check.
---
 src/dpp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index daa49410..f1ea01ff 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4067,14 +4067,8 @@ static void dpp_pkex_scan_destroy(void *user_data)
 static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
 				const char *identifier)
 {
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
 
-	if (station && station_get_connected_network(station)) {
-		l_debug("Already connected, disconnect before enrolling");
-		return false;
-	}
-
 	if (identifier)
 		dpp->pkex_id = l_strdup(identifier);
 
@@ -4194,7 +4188,7 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	if (station_get_connected_network(station))
+	if (station && station_get_state(station) != STATION_STATE_DISCONNECTED)
 		return dbus_error_busy(message);
 
 	if (!dpp_parse_pkex_args(message, &key, &id))
-- 
2.25.1

