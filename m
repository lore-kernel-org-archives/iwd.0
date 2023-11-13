Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ABE225DA
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/3RQsAU"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-da41acaea52so4816328276.3
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 09:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699898045; x=1700502845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9rzj5KgQbojzFaVaUUb2D0xstnDA8MFfkO7zVZAkBY=;
        b=O/3RQsAU7RZH2UW2Ft1XrplfziDmw8yj1auXJjMRp3Bol7C9Die4Cq9CxY5NrRY2YR
         M42iwh2reFj03Xvj0KhByijdwu2MtV3g7j4wvpx7zDUObsTZd1iSlG9YFhbKFaSxn2pn
         GflJWsjyEwpbpBCtUaPn8GUpOgwQqJzKiX4NEvzZdiVRRO6y24O5h4lxyOSjJsy5rqPk
         n6gT+ydVGFkCzG0w6/xXYP1j4orK1IOVONG/yjr3DTk5gVTtuT0E/SYC+ud14W8pl5Gb
         tAs9sG8R7I4BoOiPd5EajYhRNB9vEL2ILbnTZAq1QLIYQjMg3MZ0y2T+y0dLEExF1XgU
         hXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898045; x=1700502845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9rzj5KgQbojzFaVaUUb2D0xstnDA8MFfkO7zVZAkBY=;
        b=NSCtkeF5nmPSJwqvZX6b3PuGwSt/bu4mUnL5h4R+ez55eL6QA6WuQepnim9elzVXIs
         /p0GekauGdzuUo0MWUVo+kPk0Yvylfwx+IWr92SLjgAarHdVerxvqb+jEMjNCGEBIoRP
         Y82rYLxokrMhZxei65eM93oDTe5nUMIy+EX161/83oLJdCl+Lj4qGApx8cXbjGnJABa1
         sY1fRmEUrnt6ftNVGANE8susW3IQBRJivqWin+soZmUb4Ucvf5M4wxp1ss2uC0A5wwTm
         SxVUgE8U6kcK6/FjRcNLQd7Bc9L9QRSxW1JxjMo9wFwVsTD0rlcWGLdYxTqQCvTEUPYy
         5KUA==
X-Gm-Message-State: AOJu0YwdDzBQ5MHcZPtQ5Oe8p3dGGSmIpxfgnMHuULrwEXtzTIThl9al
	jWTCmagkki2NEYCXk1ocNVwYw6weqc8=
X-Google-Smtp-Source: AGHT+IFyn+pfEq7Ad5UUKvZ5BpFoRB83pp7Mk86vpoYsPJSjlJiGm4ynLLEh8T96TLN9BM/U0Hq58w==
X-Received: by 2002:a25:6891:0:b0:daf:7468:459 with SMTP id d139-20020a256891000000b00daf74680459mr5128802ybc.3.1699898045250;
        Mon, 13 Nov 2023 09:54:05 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id n11-20020a05620a294b00b007756c0853a5sm2010975qkp.58.2023.11.13.09.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:54:05 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] dpp: remove duplicate connected network check
Date: Mon, 13 Nov 2023 09:53:58 -0800
Message-Id: <20231113175401.343239-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dpp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

v3:
 * Just removed the extra check. Requiring DISCONNECTED is a bit
   strict since its ok if station is in an autoconnecting state
   (just as long as it doesn't actually connect)

diff --git a/src/dpp.c b/src/dpp.c
index 23010a05..3a740916 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4001,14 +4001,8 @@ static uint32_t *dpp_default_freqs(struct dpp_sm *dpp, size_t *out_len)
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
 
@@ -4120,7 +4114,7 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	if (station_get_connected_network(station))
+	if (station && station_get_connected_network(station))
 		return dbus_error_busy(message);
 
 	if (!dpp_parse_pkex_args(message, &key, &id))
-- 
2.25.1

