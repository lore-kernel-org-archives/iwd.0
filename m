Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517D212D83
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299314; cv=none; b=M0JXaW126LQqgQh8xBWVnn90zEaWV5YfHC9piCMILdG56hC6R0TnFG58ihBbqBNlfUdRKEdgJ+ZIKd7k9QWpn2iUfaxqbWBxHR0pHaAzddDNB3uwQV4h8XoBh5ac2y2Y/+Ay0bAQ3LmjSxW3RDjZ+S5jjeo7Y/wN8PiDfrm6ldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299314; c=relaxed/simple;
	bh=RWtUVpuLAk9q5QfCW8mCP4ulOJJQfhaA/L3Qjnn4pxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7Z2Kcb4Qhiu2LuFIjY6os5nvC9b1GhmlSp2Y4kJqpCwOm65H/v3ndancdGzUWg9Bh9FnFYzgmVY6a+TpeWWunbQIGI3+R33+6tIYUx9Nt0ePHYiupsXr/hgRiNT6h+Ib0qojZPJF1aA+H/FZPMJABvGR5tLGfAINfwX4EbUoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/shAF9I; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/shAF9I"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-770593ba164so3118075b3a.3
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299312; x=1756904112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PknPq9MIXNlKzoHPG9uvbX6Sp1aOQ6xwsnqpgo8l/J8=;
        b=Y/shAF9ITAeqnd37V8zKWlUoPG7nlVeCf/wVaqw68Z90HbxM2kKeMJ+EQr8w+dm+aW
         Pu12HXuTX1uQXSDnCZxPtp8ePOl5O3FmlNYWYgkEEarTbpP02J8Kw4EK8SWjWM3TYyRK
         vJ6irENIOaZ2B/MKsiVG+hJpU6sRtPh8WrPLGSzsTY0zZivR7wsX1rcHBna+nccACtHR
         NsPhS7xRRGhIA2EJPIAVuugb3+Og2oejQ+aXApTiqthdxbYwOgscLAlalUgS9WEXQ5ra
         /Epw/JIMYMtjsrZ+5zG9Dcz40o2PDVLIIk9GbfmhlanzZv3i6i6EVeTPt+3rlEfjen73
         pbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299312; x=1756904112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PknPq9MIXNlKzoHPG9uvbX6Sp1aOQ6xwsnqpgo8l/J8=;
        b=Y6KTAhbLDEKXEIYg3tdq57rzN8e7p8Q+PSFzzRJVnOC5F/GdlmwP2yMq2ep23xnRA4
         NU514E/3L217fsSdvJJ9XJvFVO+FHq2RMQIDTZ/OA097zxOUWyV/+kJ9ZvDJ/G9h74eb
         o/d6EtYenJh/FGDgGYD8q47sPS9rSe+GJvRjYQO5g/d4Qw94q8OXdr617g3bqpEedbb8
         TCdjGqr9QLxPRc85zVGPoOwvj+Ynu3LjslhTOreiYMMrkj6sNwhrAcI/pprjnpiBnQ91
         ysCeb6eB9Lpe+LaN2+jKXs4fzVMnZCZbYxrg/tPC1ToWfiWMDcl7TR5po4MRskF23x7+
         o7ZQ==
X-Gm-Message-State: AOJu0YzBx4uBD4DuAlPFlGI8PSzngkD8Oo0t7q6dCSeTX62/GdFuCQ2a
	EmdykVGELFQcG+RJ/RMkEDwqXXnkfWyiBWoY1Fw+iGzpBUi2uErtufub99kllw==
X-Gm-Gg: ASbGncs0zSkoH/aSS/T2rJnEnt7oGA7lg3Hsq/AsBhLI871FA1f3F1AiODF1ue6mVFl
	J1jrmMU5oK6LElwlUmNXMz/BZKWh79xtqaLEaa+v6wiAJrzwyRtQr6gRRLjZQEwUkXS58b5gpK7
	LGl0AKHPyTLQ0tjsL3wGIeoghTfGOxG4zGHn/LKiCbrFFfaNPDi5dgKEzRMf7hs7XgQJK8czEIl
	Bdnj4kgKj+AE2+2nVf0TR9eWpWXz3oq8apk4b1nJWenuDmzAVwAGYRbvE5N3wVR9TGxij8fjdge
	hGkIbW5HP50Dv15GfOOSry89TRkBj8jsyTEKDK9nO6K6xRJLT3aL4GXO0MF9bIbWhcpGBsxM6xl
	lTHnVovPEKUMfAxZe4+MJmceuDU5rts1EPB26papsyPHU5k7oc6BDj9wFJvsFROOvi8FiZOcyR6
	3LZW23E9YEzDfAcP6Cevc=
X-Google-Smtp-Source: AGHT+IELVCaRpPebHh8BVraVL6PVDA8NF6foqOcPzOu7vYhO31GkiYUr8gOnVEpcmCNWQa6fZIQxcA==
X-Received: by 2002:a17:902:ce01:b0:248:7b23:5129 with SMTP id d9443c01a7336-2487b2362e2mr66284285ad.16.1756299312413;
        Wed, 27 Aug 2025 05:55:12 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/11] station: check vendor quirk for BSS TM request candidate list
Date: Wed, 27 Aug 2025 05:54:59 -0700
Message-Id: <20250827125501.477908-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the AP vendor has known issues with the preferred candidate list
ignore it and jump directly to requesting a neighbor report.
---
 src/station.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

v2:
 * Reworked to use variable for better readability

diff --git a/src/station.c b/src/station.c
index 3d8eb36b..4a29c9c1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -64,6 +64,7 @@
 #include "src/eap-tls-common.h"
 #include "src/storage.h"
 #include "src/pmksa.h"
+#include "src/vendor_quirks.h"
 
 #define STATION_RECENT_NETWORK_LIMIT	5
 #define STATION_RECENT_FREQS_LIMIT	5
@@ -3266,6 +3267,8 @@ static void station_ap_directed_roam(struct station *station,
 	uint16_t dtimer;
 	uint8_t valid_interval;
 	bool can_roam = !station_cannot_roam(station);
+	bool ignore_candidates =
+		station->connected_bss->vendor_quirks.ignore_bss_tm_candidates;
 
 	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
 
@@ -3383,7 +3386,8 @@ static void station_ap_directed_roam(struct station *station,
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 
-	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
+	if ((req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) &&
+				!ignore_candidates) {
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
 				body_len - pos, station);
-- 
2.34.1

